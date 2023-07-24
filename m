Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD075F085
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGXJvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGXJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:51:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8AF2130;
        Mon, 24 Jul 2023 02:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdyQalQUiejNWH5WSjx4lmHvV3e+E874qXM3aNbocJIYYBUanfJrwM3enWwpG7F+rOjnfuVnSheQF9EG3pTYHXbNYrO8vNB9Y7HgcIpByzkEOSJ3DxOtst6taaUdkjq4aQqYOA7CSW8jAKgndAkmUFdyT3liccaFSQzXn/PwYczsoTmLBQ1iUmhZAX5mCZZG1bDsFcB2IF9umaFIXIwZ5jObFGIwmqI2WfvkqPARmDjYLrreo1e3PQ9CqjGwyolfMmOTm4QGaGz+h+Ave/lkuXBSRM+nOPeBgqMXzM4aLMuCde+urbakfWmJT2RQjGSAQORb9mTs3HKinzgZvJ52WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvXMC8eUybCpULtrz587DsbHI2DjV4FnUPYO56kXCGM=;
 b=jY1BlotOyx4ZSiVh4ODaN2FDanuA6dZdJz/sxv0BCyQvddfVpXZirm9WMeBXZmDfBHlTiEevxmzlXayYi5rMRukmOX8rlPm9NgN7BuZfygHyh0JXeXWBLuagiI3QJdlgDtmjeAnbl403RnidoZEu7BX7GsyQHT6RfVbFE7QWahMdWca7pXd4E2vTyJkIyRH9c9j7xRDDJiY3dJh2BBmF2Ovhs5BHrecHa1Z8nVyjw5jOkni/rX6zp0Ldo+LYbk4Llq15EkVCNHz7KE76i5vKEmH1Anv9hsZGvLtyxB9T4ihQA9IuNZfrH4LQ8Aw+Mk4pqEna0T9XEWq9XE1maFFMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvXMC8eUybCpULtrz587DsbHI2DjV4FnUPYO56kXCGM=;
 b=L9JBZaenqeC11c+S7PCGVYgd8rxIDuIIsL4c2z8/JoVzhpwW2bTQL9WkVpNNtqI4vjH23kKYQIRNoHj1PK8v9BIJyIt16mlGrgUBdYrGRGJ+SDMaW9pdKjmjgH98QN28AkNzRvkl6WmuHFkt64AxTTNekvTpd+bbmPzwkNrYO6vseHvd5Wg/Dbfaw6VQ+OeMfJmZW9U6eQcNwTR/5xQtk9x3RZudbGoQ2exXgtdAYUTMqn4N6piiI/Oplf5DGQCcF/cThxGTSAEZK3IRMSH8zg4oKCAQKtCmx2GPvyo3kJwoEIDn5n7qbnpiQRaWmGKx/SR4WWJkEFZ5fJrd8TXTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VI1PR04MB6973.eurprd04.prod.outlook.com (2603:10a6:803:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 09:47:51 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 09:47:51 +0000
Message-ID: <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
Date:   Mon, 24 Jul 2023 11:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dingyan Li <18500469033@163.com>
Cc:     stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2023072159-carol-underfeed-43eb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VI1PR04MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f66659e-0e8d-4501-08f2-08db8c2b0bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHCliCB3nNEaHvq7Db9wmjsQVcmkL0cZJVgmFchmCHb9aXW4EUObjMjU5SrJq9N1/PZaIO5ID4LxK+KkYDQsNGITbbzaWq5Kr/CRzmDigiHXZD8TlIBQhyPHdsZ8AduI7Ynblk1Ts0ByGrWnhZYWtv6D8M1KQgTBncItBwzWAXtdcZa523EFjJ5XBQ0aRwv8KHtycrkGU/Iat6hxm6HW2UpZPICkzjii+uXxrAyvu97KAZBkw043puHHco+bAnf2rS1aL9tp/b7ruJKGqY//YhXqYmOL7HMNL43aHQQGormnrrWHLDcLY2wKosl7yaqhmwF7r+Kos223RgpC/e8S2e1JIQ6siv/VwejMWywKyqnyMaswnXva4jaV6rxfQSS8GPoHLEsTyVnTBn/hDLB2b0XXC0ug7rnjd2pVQ5lM5ZgxAbA3uRfcHfiwURxkSMD15C2DrrDXz3C71qDrYv2b5hYeNyFzXhYOCh7C+giIcEvjN/Wgf2UWA13o/97/Lu/+OV25Txza9paSYoWkQIed1/5AbGAT6iJWMpSoTJngA1Oh/iq2FnKuN1QVHML7LP9E6r0AVANE8aB8vlAr7QoaFvwhS7X52ZJqDn6leq15LeJOUS3LUkFr1oDwrOrS5BS4AUtfOrGMe5k097Msr9g8cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39850400004)(346002)(136003)(366004)(451199021)(38100700002)(53546011)(2616005)(36756003)(83380400001)(8676002)(110136005)(8936002)(5660300002)(478600001)(66556008)(66476007)(316002)(4326008)(66946007)(41300700001)(186003)(6506007)(2906002)(6512007)(6486002)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnE3NU9aYTJwMDcybFRybFVFeWNoWkpYa2pPa2kydUpOdmM2MEJrYlZ4RkZs?=
 =?utf-8?B?S3VUMU1DeFlvdlMzOVlObUp5R3JGeXpOZXFkdU1neWlhVUkxZVcwNFdCYWF3?=
 =?utf-8?B?QUp2QU9URktqb2crZXNZTUZyS1Y0ZFZ1QkVmZUc4SkdYR1N1NE1ZVWh6UzlL?=
 =?utf-8?B?RjJhWHNLZ3Zxb2RlMWRLWXpNYUhqUTJYdGFQWHFHMGhWYlJCREkyVlBaZFpG?=
 =?utf-8?B?a2NORWU3RDZvczl2Rjh5ZmNQZzFLcXJyWUs3Z3NGUmtrZEppcWx0bzM3bUF3?=
 =?utf-8?B?ZTZWTTZ1RDZUaXhHTkYrdDg4aldyMG0rTGVMNHlZdktSaEw1L2RJUDhvcnJY?=
 =?utf-8?B?QnlkOCt1cVd4SWg4ZFFvMDhXMlVYVGIxWUFyTzlLdTg1eDlYalVCWHoxTWd6?=
 =?utf-8?B?SGpCZ21zS21UQm5nenRscXkzdklrMWN0SHgraWovenFJQ3FteVR1R1Q3ZUIr?=
 =?utf-8?B?QTZnbCt3NFlYblFsVDhnYzlBL2dYNFZFYWgyOWFKd0VRSjIzMGtWR204bmhT?=
 =?utf-8?B?eFV2NGJydDZvTnFOby80WTQ0bUVhZGJMemdCVXo0NEgrR1FnZjVpY0N6VmxH?=
 =?utf-8?B?SnNvdWM5UnI4VThuR3ptei9TWW90dkR1MTNBc2Y5cHg0ZGQ5R1N6Wk92NTU1?=
 =?utf-8?B?ZHgwWUNLeTBETkxWbXVXcGgwcjVndnI5cDNQZVp2WFRmVEplb1BNTkh4a1RN?=
 =?utf-8?B?VnR3TU1kTitlY096azVUVmowM3NHYk80ajdML3FualVRTlBrbUdNYUwzMEJT?=
 =?utf-8?B?MGl1R1VPclA4S2dUVnE3OWlhVmc0Zmg0RWM5MDZBelluK2NjOEdROW96UkVH?=
 =?utf-8?B?UEN3L3RGcUgvNi9iaUtZdkNnZWlMWWtXS1dGaDU0SktFVVhhRU1XZzdJNG4x?=
 =?utf-8?B?T0htcmVtLzZyUUJ5QnVvNE9Qa1hwS3p5cWdQN1Z3OXlaZ2FjK0hzSlh0WENX?=
 =?utf-8?B?dXBxdXNBOUZiQWdYWU1pZ1JnZ1NGWk1kVksrSm1rM0t6dkNIRDV0eUFwWUJO?=
 =?utf-8?B?Y1JPaWNnUTJyekVFVytvZ2czNHRmeGpZU3JwYy8vUGFkN3cyZXBMWWFWamlY?=
 =?utf-8?B?cHFZckI4eWNpRjZGcmRqRzBzYkh3UEFuN1BYdzJFaU1wYjFhMFVDdGVsdGk1?=
 =?utf-8?B?VzMyaEE1c2JPcDRFeUJjc0o5a0pmckZWZlBIdjV2Q0MzeGNSZVlMaE9nMHdt?=
 =?utf-8?B?WGVyVFpHMm85YzRyY2RySGgzeW5keTB1L25DUzh6RExLanoyN213blNXWVRF?=
 =?utf-8?B?dStVSHdpZWZ1VW9BWkJJV1NxSEJBWGw1VnAzU1FxSXphMVBzaFJ3d01sUU9k?=
 =?utf-8?B?dG8wTUh5TkZENVc3b2dmRjcwcWpRREZPNXI4b25qbDZZTXlaTHBkN0psS3Rh?=
 =?utf-8?B?TGJKc1NPRnJadW5XWUdGeTFPTEYrbisxOUwrbWRWdUVuYURmcFNBdXBGanNx?=
 =?utf-8?B?RnBaK1FOWW5idENVS1BLWkN4MHNSS04zTFdocG5FQ2o1WjR1YWxvUnRhb1cy?=
 =?utf-8?B?Y25FUkFpSU5teU1JVG13eTRhbUJvV0tyWGlmUHNINm9Xcm1aQXcvd09lRDFt?=
 =?utf-8?B?OCtZNHYwMnJiZm41bWFmalV6N2FjNDJ0d0NwdXNiM3JMT0NFeFhIaEUzejFU?=
 =?utf-8?B?NURyYzYvcXQzei9ablhRZTlrcHlPcVBUQ0lsRjZJUkdhRlBvYXhlZUYvTWMx?=
 =?utf-8?B?NVpaUUVUTHdxMmxYNkhzK3VvZGtrbW9SSE5FY0l5RlM0MnplakhTUzFRRUp3?=
 =?utf-8?B?RzRINm1OZ3M5eVJnWTVpSk9XbFFVUFhTK001U3ZUQVZNNFBtbC8vYW1tM0pU?=
 =?utf-8?B?V2FpRmJiaWpDaVlCQnQ1dmUvMzIxUStSU0RVdmIzR0xDai9pSkJ0ZWdsOGFk?=
 =?utf-8?B?T0Z4Vkl1UDJYcUU2c1cyN0V4eXZtSDhYSUxKQ2hjR2oyL09TblNvb0JoQ20x?=
 =?utf-8?B?eUdVVEF0MDhSMk9JRm13NThsdWM0M2VGTitUemZIRk5QcVUvY05sNmNwaU1S?=
 =?utf-8?B?aWd3V0JROGJxTTkwS00vUDBJb3JwMzUvU2RzZ0RFRFFjVE5oeEtTcHF2K1BV?=
 =?utf-8?B?czFrNWxSekt5LzNmRk11U3hpYjNGQWRRYWplbnBzMVR1cnVrQWdMN3M4WUYx?=
 =?utf-8?B?bnROT0RwVlM1NEtCWnR2TGNLZVplaUJwSFVkQU1kNUZLSFFuek1mSm5HNnlt?=
 =?utf-8?Q?wlPTxdFb7kaX8o09zuf3a18=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f66659e-0e8d-4501-08f2-08db8c2b0bb4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:47:51.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyU2sdc+afCTwUbbHsmTCQADhC7CBIQ+97bRKVvtcpZdzINMhXv67OKIUyvKv+Rs8VDSg8xOu7FAezkukQxlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6973
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.23 16:51, Greg KH wrote:

>> 1. By saying "be documented somewhere", do you mean there is extra
>>      documentation work which needs to be done? Sorry that I missed this
>>      part since it's the first time for me to work on a kernel patch.
> 
> It needs to be documented somewhere, otherwise no one knows how to use
> it.
> 
>> 2. If no error, returned values are "enum usb_ssp_rate" defined in include/linux/usb/ch9.h
>> 3. ssp rate is only valid for superspeedplus. For other speeds, it should be
>>      USB_SSP_GEN_UNKNOWN.
> 
> Ok, that should be documented.

Documentation would be good.
Where should it go, though? These enums are part of the uapi
hierarchy. Now, documentation for uapi would be good, but we
should not mix it with documentation for ioctl
That is if an ioctl uses an enum out of uapi it needs to be
explicitly mentioned by name, but documenting the semantics
of the enum _there_ would be wrong.

> 
>> 4. I found in libusb, there are two ways to get speed value for a device.
>>      One way is via sysfs, which has supported 20Gbps now. Another way is
>>      to use ioctl USBDEVFS_GET_SPEED. This is when I found this ioctl can only
>>      return USB_SPEED_SUPER_PLUS at most, it cannot determine current ssp rate
>>      further, no matter Gen1x2(10Gbps), Gen2x1(10Gbps) or Gen2x2(20Gbps). So I
>>      thought maybe it's good to provide a similar way like ioctl USBDEVFS_GET_SPEED
>>      in order to get ssp rates.
> 
> If libusb doesn't need this ioctl, who would use it?  We only add apis
> that are actually going to be used.
> 
> So if libusb doesn't use it, we need a real-world user for us to be able
> to add this.

I am sorry, but that looks pretty much like a question of API design to me.
To what extent is libusb supposed to be functional without sysfs? There is
no technical answer to this. It is a question of design goals.

If we follow the precedent of c01b244ad848a
("USB: add usbfs ioctl to retrieve the connection speed")
then we should apply an updated version of Dingyan Li's patch, preferably
coupled with a patch for libusb or we go and deprecate some ioctls.

	Regards
		Oliver

