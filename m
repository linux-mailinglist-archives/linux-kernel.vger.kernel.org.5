Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A582761B09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGYOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjGYOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:09:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649D01FCB;
        Tue, 25 Jul 2023 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PipbajkNPFGBzxX7P5Rrl+sQnVEigpnv6wrQFlJP+3gHh2Ff2dK7DRsLa1zlNB9bLE7+/owxALyCIw2tyvOEFjGFv/IXrAsNOR1r9UdH6mrRJ6+GCKdZqYkqqgFsupaQfL6pKeACJ+tGAe0VEgCrR/K1MMTwhCn0+aygbpd7NaDtEmwHM1007Ikd+GGg9QRCuAEU9D8vscjmR/HOocB4blnlUawR19/KRph9Na70XohNWmoDdZMZu+Vypl3oMGqe49kc79g0V+k/g5Dc97cQZnYInJ6fc00xF5nK7LrOu8CP9JLF6ZvmWOKK5xkZ6bDNFVJlifCIDARIh8WxcsFVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1HkaqJSZFQieF9UOPdhMh1McHlagLrFVol//XoyEIU=;
 b=UBaTOCVuwI4/ZlxlD+TrYhLRgV9ybmXX3+nKfdCjslHXUQxXwIAy3xQJBbMUF6A76dLCq1ZV42hmNUEongt/sUfRwqJFNfU31/LV5xeJMPFj+ipfBpXVLnvPwj5HKh1XGWYtrQhOUjKFXjpAGRqt1k+LBfGS/7UfDIXFcvuwPj5nBGn0HMJXJ+J2m+6Ba+ZtdZJcuC9kxRyacYsXP3Qsc9WLvRwNnepBTIgeW4nyoovXR3YOEHGsr5cFztYaYl8e6JHmJzpY9I1+vpemFZ8vT+GF1w8TOFM/C94t93F70bqIk4XIjPQkifcUDJCL30Urov2L1t5YBzog7jKU2hPt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1HkaqJSZFQieF9UOPdhMh1McHlagLrFVol//XoyEIU=;
 b=H3Y/L4/kfNDEgZYQDFsT/grYk3iVmqa8WExaC/ELSTv/NlYzlex9GiehVSq8iE4CMm7xSN8Ln39ePq9HuONl836B7CqLRJ0yx60nZNE/p/u3zYCQeH3CVJ8covm9ZJIpdX/B5zCMOqV40Zs7K4ltEcpm5lTUElG6c69GdCoJzugJwUWJN1ofJDgDk6yJwpGAmQDKtIyE84MrlLW3iBBzTgbxuTMjIJ4jVMvzISfkkumaZweLrWhdvOck8WQVhoO9ZaxbAO0CctT7Rjv4lY6IR0z1EPGZKqUvKSd7VEJFTlaDDNrdfwPMC/GHiICx7XX9m38gtbs1xVbMFqLyYRYVog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 14:08:47 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 14:08:46 +0000
Message-ID: <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
Date:   Tue, 25 Jul 2023 16:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Content-Language: en-US
To:     Dingyan Li <18500469033@163.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbcb968-87f7-496b-6bbf-08db8d18a960
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzpCY/VYIxgSOCo+bJNIvN2EIaP6+6kkBzIToWhMNPFSCds4ISHCi3qXnseCfDjPB2SUhNBznZYJYbmcSQeJpifGlYEVSHF7tuz8ftSSti1vXaUCWwD74sOong1YO8CcRD11BJvkuK5INzM6Gz+aIThSlMv2RYSRmHJOQDj4/1UH15iGINtyg8BmHtWRyq7aQYGFvn9phmQTNIpeAXA1v9NwxJe4r5gr1Hku/wSGsf3ekXFYKuS86UgFjeQ4ax9tlBrRUD2krypN5Va9p9Yxq6OqBWfLoTMhhUjNy1aCjgUcvZ9lo5ckcr2ZqKXHkCrSfZZIdYQQp6GBBT40/xs6lV/2FNwZZkhhgF+NuYs04OfeOuhLwIlEZ4agDb84z4iXGK5koRNIwF6XtmpPUa7KzP9fWFxkb+28/DGR3s7Oqp76iVjcgmlPuETWbL4HuuprTRxJFpMOE/uLQB+eC5VdtT+mFS9G3psHab/moZVy3/ECvKtz2C32qSpAosKfkS9OPVCUuEofUJrVqSKPA9fQFUnnYOuD8zRUjbpWGa66NaNatN5J2TGNYmNW9xrbLwwusjDy+yPWT+KcW+YuwjZ5CGjwVhRij5eOTs6lWyCIC+To42vZyiXkF8vzkcGQ0CcAQKpt/gSEB4//CdTuIp/8AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(2906002)(186003)(6506007)(38100700002)(2616005)(53546011)(4326008)(41300700001)(5660300002)(66946007)(316002)(66556008)(558084003)(36756003)(8676002)(8936002)(31696002)(66476007)(478600001)(110136005)(6512007)(6486002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZLR3Q5ZFJ4b3ZtMG5iZHBCV1pyaGdzSEw3bmdjUFNKMmdtc2hMNWRJVzdu?=
 =?utf-8?B?RnhEZ01jL2UrWGQvWVpyc1VlTjloUmZEeEtSdnpJbGl4azJQanJ6Y0NkRURE?=
 =?utf-8?B?dk00TG4wRmxxSmozZUFEc3A4UlFBZ0dMbEVSaWxGMiszTVp6UVVMa29jRXUx?=
 =?utf-8?B?aW1sNVNFekp1ZE9kRHp5TFlDUWhWYlJNNEE4RGhtaEYvc3ZUdUliV29GbytY?=
 =?utf-8?B?akFUODVTb2lVc3RqbHl4YkZOaElmY2t4U3NDOHNnSVFBV0I3eDJwWXE4ZzFK?=
 =?utf-8?B?VmwzR1VTczRDTllvcjNLNFZzeXB1OUNEWDhNMk5LZ3hoSU1KVGRmNmcrYU5F?=
 =?utf-8?B?WVdwQnp6TG5jbmd5Y3YyYlVVazRaWjV5ZnpQQ3k3ZWQwS1VVSFBLNXJpSmdO?=
 =?utf-8?B?L0xtbjNJQTFBSEdaSm1aNXlIcCtUTFdTWUROZXpldlg1MWVWb05COGwxYWRH?=
 =?utf-8?B?eFBhUlRFU2Z4NFBkWXcrZk5OODJ4V25nUWhtVENrWHo1bzM3NG5NZUtjTTFr?=
 =?utf-8?B?S3VQWUFxY0ZoRzNlWWthcVdkRklqaXAwbGFQM2xNdkZ3Z2hPYWtoSHpJZ2Ny?=
 =?utf-8?B?dERkWVYxeDdkSHg5RXpweDN1V1BCdWk0MTVVbHR4enNwaUNlNk1kNVVnMzB4?=
 =?utf-8?B?TXJyWnNDQ1haYlNGOUc2bFQ2YlNyekt5VmlqclAzb1d0REZiZG84QTBZdTFX?=
 =?utf-8?B?Ulh0MktHZzFtU3pad1R3SkQ1dldwOFhkMFFuak5tOTVKMHp0VzRwRWMxNVhp?=
 =?utf-8?B?ZTh4SE4ySy9tOCtTcktrZVFJdE1Ydm9xZTBKano1ZWx6a3liTWREODJyVXB0?=
 =?utf-8?B?dktkQkhGVUYwTWYxSTVleGg1TEhGZDNRZDlYRHJHWGJHTkVwNzJhR0NGYlpU?=
 =?utf-8?B?REtQQVpkSC9oQTZqVGtNOVBYNG1GbXFEL1AwblBwV3NCSWhiOGgyc0hsR3NC?=
 =?utf-8?B?RkNBZUhQZ3I2UVNJMkIwUDA5aWM0Ty9PZWJ3d1V3QWN0WVExc2pvOXhYWHRE?=
 =?utf-8?B?RFUraGhNZTlZUGE1N2Iwek4rS2VKSkRqWUJ5M1ZZMWZ6OGNwbjVZVEhhZU1n?=
 =?utf-8?B?Nmp2VVRGRFNoZUROYVR6d0hyRUJjcEIxQ24weDNHZXR5WWNzaWgyVUFiM2Iw?=
 =?utf-8?B?ODI3WmZlSW5EeVpVYjV1cHVxMGpmSHV4eTQ3azNqMUpaK2JGcSs4ZUZlblVJ?=
 =?utf-8?B?M2JxSkVlTmZXeVJPRHUvd0Z3WGdnUE8vT1AvSmNtYlFud3VlVDBseFZhZHh3?=
 =?utf-8?B?OCtDZUVtZ0hqQzZkbitEd0pFNGhwbFY2d0xMU0s2dlFhelZzUDZxNjJzUWFZ?=
 =?utf-8?B?b1lkZ1NySGRwVlROM0pJcWlGcS83KzhhQ04zOG1aWDFoa0NtNXlsRnZXZi9s?=
 =?utf-8?B?b0ovOU5kNENKVWVPZlF6SlM5SUdWWG85Y0RSWmpFSE5XY1BESW9ZanR1TUpM?=
 =?utf-8?B?OWRyQi9BNXd3QUd5VS9jNE1VUmtCS0VhME9ray9PeGJncUJOODhnT3ZtVSs5?=
 =?utf-8?B?T21vTnhnbURpbG5kRTVweDZ4Vlhsc1MwbVU5SFRqUHhOSExPN1paS2dWdDFk?=
 =?utf-8?B?K3JuN0d2d0VFRjRiOVRKbXY2dFVYM0dvai9qSTRweENCTVpBSEpVZFZIMTJu?=
 =?utf-8?B?U08yNldrbjNBQmtFM0h4NEhPekZYR0hZLzV5cXlHK2RZZnFtZUVqU1o5R2Zk?=
 =?utf-8?B?SWNxT0kxV20wRGV5eWMvbzNMZGdnZi9aNGczSmx1NGJ4SjFXUXBmNnZ3Nmh3?=
 =?utf-8?B?MUF3ZlRKY2NrNGtHUTQwQjM0WkVTS0JFSER0VFN3dDRvck9ab1oya0NBeWhC?=
 =?utf-8?B?ZG5tajZld25VZitoVlRmdE50dldiR0dBS1FZVFRoTnRoZTNUcHdLb3hPU0l3?=
 =?utf-8?B?Wng0UGQ0UlJrdWpVRG05YzNKRVNkTjlqbTN0MllMOEJ3UDR1ZHduQndHWlBY?=
 =?utf-8?B?dll3VW5zZWRacFE5MWY0MTdSbFgveXNhRE9GVHg1MlovODBKQmdGMmdUVHZn?=
 =?utf-8?B?MTRwTTNJanUxdkM0ZnBLN3E1OVQ2dHlwTUdaVnJpYVIxZlBjRmkyQWJmTWc4?=
 =?utf-8?B?TFpkQ3JPTlRrZmlXc0NGN2pvZWZ6ZStzaFpNTEtEdWdoanZpb2hIalZ6MVU4?=
 =?utf-8?B?a3RYS3FhV3c4cmp5bmhieW13ckRuR1JXM1Q4cThzSm56MFBiSmh3SHUyQU1a?=
 =?utf-8?Q?epgQAFQqkUmmwKEGGaPrMsQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbcb968-87f7-496b-6bbf-08db8d18a960
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 14:08:46.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weKibetl+R12l1llkCBdgNz+AzJfkyjSA8rSHINpAg2nmN6SWQR5pgDOdLun8LAwdWDl0fiFpL713eprYDqgcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.23 15:54, Dingyan Li wrote:

> If we can't "deprecate" ioctls, can we change the returned contents of existing ones?

No. Absolutely not. That is totally unacceptable. It would be much
worse than just removing the support.

	Regards
		Oliver

