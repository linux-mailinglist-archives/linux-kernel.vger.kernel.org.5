Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19587FDB86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbjK2Pd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjK2Pd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:33:57 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A2D44;
        Wed, 29 Nov 2023 07:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpg3dUGGcy+BKya9K7FHhtobx8QF5dVzZpo0qT3M/ASMjYjzqywKPh0iAEVjqxW2iA3U7VZxlqJeSvMQWYf1O+DQr4ZFbVtwJtb3Cuw8x/vLajDFEDi49qFGcCg3KmH5fzfZShoGlWt0zvkz9TOFZWfDK2OXc7vCX2anXtmXt5eo4+i+8W4XRdXohDtO5l9YtNS1UHSYIkySjbRKYPT8ID5aa43uEZmvYaTaHj3ot8WBQAdBWNE3ia9Bs1Q9OueR3bOLU8qwra5cXDcicAdZqhs/EEZFvG4pbp4ffR6JQ8gpsSlDNTa3Lrk6hiq3ACOCgzdUZ9Hm1y0SGAOGKh9W2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkBx3d+u+3dMzncLEMOm/rFUGOv1bnHg4tZCu1LQC98=;
 b=KOqhiJQWVVn5nLjMsWQDlsETyItMkxofZFrsh804zr8g4e/yERKDoddZJI8e/SZ9WWT1LWMJIwm79HqCVOBjzg3KPPmRqz1EAiAow1B5ovCIng/JG4pTj5yPyjDCQWPvAFb6elVwgCBs6DV4RbElu2LcJqiJxCXQwExh93w86i0SfBZf3ArLZI+vUTcPCahoNkPDN3/jMXS4M3Z/fosxZEGMuAsyKg53ghseMMj/UaiUjNJasTjBp5DEgEgWNy2DjYhCX7FBixK92NGTOyZH0v0ZdVaW0DgkLORwTDXCEQe1/149z8uSrIsbhkwaqbfity/E6u9Sum0wlHZYq8QVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkBx3d+u+3dMzncLEMOm/rFUGOv1bnHg4tZCu1LQC98=;
 b=MRbAGApywmBvhwXYAubiwzOO1qwNUYf7y72P9pZr14W+Xj13dhxBaYf3kK31sOl0IJ3dVkXPpMskWESvDwvM6St2hGOFFkmAdxmg4/EQGNs7pYEYNTXW+I1dp5P7iajHG6lL0z7v61w6U5XFUqW73nnQIkv5wIkuXLDF6wU+znNtUc58WbhDKPk8HuX+fireodhXbP7tmvd64R6le6VPtVzGXB06Q8JUnltiroMRqA/fjwgaVTV4ge7SnsWPoZIQmixj7EO2y9ibXNcxjQidqumfa1dd5aLdwVzbRT6S6uRqlJ+xJKH4lxS0QsyKhzjp8HKJdctIEslS0BofiYpuxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AS8PR04MB8787.eurprd04.prod.outlook.com (2603:10a6:20b:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 15:34:01 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 15:34:00 +0000
Message-ID: <f684feac-2941-4407-846b-2d984daca733@suse.com>
Date:   Wed, 29 Nov 2023 16:33:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Content-Language: en-US
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231129151618.455618-1-jtornosm@redhat.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20231129151618.455618-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::16) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AS8PR04MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9434e1-9a83-48ea-1118-08dbf0f09c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CPf+PNFZezVTGWAV9zKwpcNIU7Pdztx9cGWgYkiM1aWY6nI2VHrXLHBSypIN0WLibb2Xk3Mv67W4ve+fB+ElNf2tTl78MrptCnlaYP1k81N4LQyQDA4PPKWe5hq+/WCN7vjkDSxfhuYLRXluF8osxTKO6hVRchlRi+5YKVTwqiokYe78TTVgQF/Ws6DqL7/HzGjhZ+9+NilKz8ehw0tu02gyLgX5Ksli/jNxaJ/kJn28hfBoloE2y7qgEU7IvsRiJBWDdDP4l+pje50VYVEExzl8FW5LMvZi5rGQ0nBCitfegAoXpPrqdnqxX/jKgZ/M9uwWVKgWZoaCtL1xmdtZYX8N39yA3BY0SbrUKuYiGVIyHJuNDvWe1X1ogd+gvd+AzpJo9DTKhWZGZXtLg7V3Aqq+mn8QFIktMyMh169ZLn8J8QxtjcwTKUpHRrBZCZPG2MapJFxEAM4Q1gtTM0+SrF6a8YF7r7EmbLcZ+j+CGprebpgmzfs9XYuh2vIAioHm0m66WvR72yXXMEMx5w+fKLfQaM5qWEt4fojkiWqLqmDEUDs6uRIXmragYNnCXtfiS8BoxDf5hNQZDrSj+GcubKoFzUFsus8l2KA+ReJGt9Yj2UCxX6D+F9K62w1qwvG1MLKTsnW7VD2P9cfhqOGCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(53546011)(478600001)(83380400001)(6512007)(6506007)(5660300002)(4744005)(2906002)(6486002)(8676002)(66556008)(66476007)(66946007)(8936002)(316002)(41300700001)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BPbFdPRm1IMWxPZ1JqODZHeWtIMEhMQnZsYTJGWWk4Zmx1NGhBU3pzdU9G?=
 =?utf-8?B?aEtiMkQya3ZpRDhYMVFOaWpzR0hhY1R5TXQ2eTFpUHRQRlE4SnZ6cXhqOWNu?=
 =?utf-8?B?TVMrT3Z1dnpzSFpROUFUSmVjMFV0NHh0TkVyZ2lkWWFRSzgzZ2d4UVE3bzRp?=
 =?utf-8?B?U002M3ZucFF0OEQ3N2V6amtxWGJEdjB3dlVUdkM3N1B2eWdEZTNES1loczE0?=
 =?utf-8?B?VW4ycytGL1VXZ3lJY3BJNDNCOEg1QlVzNHVFUXcrc2l6ZTdTRC9WOWEvRGNM?=
 =?utf-8?B?OENseHN2TFFBR2lpcm5pODZ3NFFNbFhtUlAwTEdNdlJTblBuSkRvZm5GS2dX?=
 =?utf-8?B?KysxSUxuNEp1dUUrd05za1V6ZjlMNzMwTE1mL1BobDYwSW04NnJDeGhlMnp5?=
 =?utf-8?B?R1pxTldwZDYreWVCVVFiUXE5TFRjSjN6N29sWDhob0tKTVNzVlcwSDNzNkhm?=
 =?utf-8?B?Z0JPOW9UamJQZkZsTEFIY2VzeEdaODdOeThxU2luWDVaWDBvMWgrVDdVbEUr?=
 =?utf-8?B?OWFqcDB6azJleTI0Z01CU0xnVElWOGhHYzhZbzFEeXIxWGFRUjhyYWdyUlBn?=
 =?utf-8?B?aEppMkRyZG1tWGdjVHJyZ2NDSmsvYmRyS2VUV2VJMUFkUWhDdWt1Mm5ISVZP?=
 =?utf-8?B?RDF3aTVYSTJFQXNlRERtNDQwTDRqQ0NDRFhCazd0anhtSEQ4alRmTmx4cFRC?=
 =?utf-8?B?cDRJT1YyU2dGY3RxV3dyd1lRMDdkSXVtR24zd1BINndkQVNRb2hiMHhFNEFj?=
 =?utf-8?B?OWRWTkN3RVZRdnIvU0FhQzZxR3R1VGxURGF6R3ZTWUdrR01vT0RUNFRkQ01q?=
 =?utf-8?B?N3Joc2s5a2ZzbElBRDZYU0hDenlTRmRJRDgya0s4Z2hWaGl3Nm16MjRGSi8v?=
 =?utf-8?B?Y0hjMGZQUzBRM0NGTnlSSkZWdW00UGR3Ty85dk8yek9zc0Vyd2FQblIvaFVX?=
 =?utf-8?B?aSsyQUhqaWRJeWxZc0ExS1VSQXorNldmdVFxRzNJOTdBMUFOaVVxbzdyOG5N?=
 =?utf-8?B?cXp6MEtCTldpZm1rYzBWblQ2Z0RLVnJqK1pFTTJWcXoyNXpKMk5zTHJpQ2g5?=
 =?utf-8?B?VlNucWpZY2pLa1hzOS9DVFJXczVzRHhhMitOblpkaUdYYTd2YmVISHBiZjVZ?=
 =?utf-8?B?Mm5LVWE5YzRMTkROVnlDL0FCd2lqTDNyK0R4bC9XcUZUSWloZ09RQjNET3Bk?=
 =?utf-8?B?UHVNWEZuS0F4dzJWZ01MamkxQjY5OGcybHFoTllTV1U5MjA4TzNyRGlFZ0tk?=
 =?utf-8?B?STFNOUwxaXIzVGZTNitjcFlacWdldU1Jbng3UEtOV2VyTkVyeGNmbEZ5dVFH?=
 =?utf-8?B?UWgrd3U3ZFBvc1Mwa200REU0UjhWNncrVjNrWVAremZ4UW40Tk45OHhQa2dY?=
 =?utf-8?B?eVRsdEwvK2luQWFmYWFaQ2gyVWJrVE1SemtPcnc3eXZ5UmQrbHVkU2NtQ1Y4?=
 =?utf-8?B?UlJWbHRIbThPNTYxUnVFTklzUGtZOGY3NXRiMlJXb1pJbjdvVlkvUmcwWjl3?=
 =?utf-8?B?eVVkRURNOGJLYkNST3RKLytwRmNDUzNGa0dEdG9ORGFsOXoxZGRhMTZIYi96?=
 =?utf-8?B?Nnkva3BpWXdDVlJYVWQ0UXExZzJDTWhlODMvRVBDdEtqRm1SOUNGZUwzckFE?=
 =?utf-8?B?ZkZRMmlBYkJlVWpaUkFQWVdoclpIQUZzSHFUaFVOTTA4SHhpbS9NQ0FQc3do?=
 =?utf-8?B?bUwwcktnYVZZVmlUU01WcUZKRDJpSHU0UUtiWWhWV3c2aDhWcm55U2YvclBS?=
 =?utf-8?B?ZHNWcndIMENjU2tsWDZVdk5VaU90M2ozc2JOUGlDUUdaaVVBLzBXZk9RYkZE?=
 =?utf-8?B?Wnd1SGhBS1pubVZBTGl5bDgwVUROSkhsRVI2QzFFd2p0SDBGRSt2SjVtUmc5?=
 =?utf-8?B?MUlQdkMwQnZxR3hha1RSNC9CL0thMjVqZmVHVTk2dnptdDU5SVVzWmhCUCt2?=
 =?utf-8?B?WEc4aiszVHpvakh5c0tCL0p5WENuK3dQUFRFc3dBMEgrTFV2cHRRWlRnUHh3?=
 =?utf-8?B?Vk43eVkvTjRhbE01QUtMUUVTaW5KejVhTVl1cXBocUZTRENCaW92VXQ0MmRO?=
 =?utf-8?B?T1lGZmlzUUV2eUVycmVVSVpob3lmM3EzNFovT0RTWWtkNW5vRWd0OXF1UDNh?=
 =?utf-8?B?RlFBL3VXZk5GZHY2ODF1OTU1ZVo1WUxwZG8xS2JhTXl0SjRhMWF6MVBabmx6?=
 =?utf-8?Q?dmL5sG08vmBu8D2Jpd1/zrup5XNx9RXwGBXUgUVDEkpF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9434e1-9a83-48ea-1118-08dbf0f09c2a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:34:00.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9PjbO1ZkqGkamvRw/VMsqtjvHbDXkQOBPVMteD62YQ8CjCAnbfbdJp/87t02L0H46g2tGiqph+4QICLnzZjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.23 16:16, Jose Ignacio Tornos Martinez wrote:

Hi,

> The reason is that although the device is detached, normal stop and
> unbind operations are commanded. Avoid these unnecessary operations
> when the device is detached (state is USB_STATE_NOTATTACHED) so as
> not to get the error messages.

I am sorry, but this is a layering violation. You are looking
at an internal state of the USB layer to surpress logging
-ENODEV. If you think these messages should go away, filter
for ENODEV where they are generated.

	Regards
		Oliver
