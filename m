Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305DB811723
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbjLMPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442310AbjLMPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:34:22 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3021985;
        Wed, 13 Dec 2023 07:32:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGDdULdeDaT+1Znnxw5mpQl+w7ShuoYkLfT575q/anVnfXKe8dv1najhSjaqKCHnLIPDh3o/KAAiixktcKpAR8buNr8JLQrG40HrbgNr7Cv7adAu4X1ofMK+bHOdsWoNGXCuJKsnkGIV6Eglbyh/ZbKxaJMGQ52b2eyRINi1azCWwnXstZY3K3o/jPoyrtA1IDTomNgCH5zQu/znN1prpFXh9JSzcapIZSlGhfUCRf8qTeantLgvfxVZiqtg6c5H6wVsjc9NKJF2p4TLyFymmRcDKyxK/TUOk6xGaO7KPYsVaQMsWtcQ44KbsH4+5/YlMHQq6K4UfGisixFV0Viwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi5QWdYREGBDf4+0LM2jGZv3eRqwhA6HxVQtYWqtO9Y=;
 b=hRaTAYHUyBmPYDyXUCMvQ7IdryBb+4MFeglXnRVo/waGJohKU0qQPjPbC7u+4mS433/Urdrxz7TDbgfFwAWn8z9Q1i/CeYHHBB9GXrVGTLHItfi7gUdNw9z+4vAkqlJW22adoQxyNTwy3sxoN7Rf7NseTJq7orAwVQjmuOrx8lqbID4bvsxXI4P7fSXtUDqKgPWqav96a+3684T5dSZLTtWQPptBWYMB2wz2/mpH9++6l2FXv9ULaNdnrsA5V1QTOzGfqb31KwhhWIqgSp1OUmCbR7WFFlpc57PJHQSJD5uR1I/NkvkSo6DdPR05Owjsga/EhFdn3aMZku/lkWjpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi5QWdYREGBDf4+0LM2jGZv3eRqwhA6HxVQtYWqtO9Y=;
 b=qfgBGbL5Sq0wqi4FKmlXLSiB0+UDUaZUdJ/BbV+XCMcyKeqgJpnbYa5szJA175WDnFCwk0omcyEa8BJMI3v0Dhbre7F85nCVPFFrJvKUxdUoUUq6s1pyuPx7yZC5I6YsP46hX5LJgIuHcyWr7sOMVds+wq7G+rUhljIFYu3Hq8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8907.eurprd08.prod.outlook.com (2603:10a6:10:47f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:32:12 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.031; Wed, 13 Dec 2023
 15:32:12 +0000
Message-ID: <d70255fb-7dc0-4119-b52a-9e8a955f0712@wolfvision.net>
Date:   Wed, 13 Dec 2023 16:32:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] usb: typec: tipd: add function to request firmware
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
 <20231207-tps6598x_update-v1-2-dc21b5301d91@wolfvision.net>
 <ZXMudF++A9/y4TNk@kuha.fi.intel.com>
 <196acb44-fb0d-45b6-a9c3-b5a289a41917@wolfvision.net>
 <ZXhq/IJp9KVCkQYb@kuha.fi.intel.com>
 <f942ad57-e2e1-4896-83f5-a1acc0805afa@wolfvision.net>
 <ZXnKqsy2rEJxmXhG@kuha.fi.intel.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZXnKqsy2rEJxmXhG@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::20) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2c6400-3384-4508-4593-08dbfbf0ad0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Du50s63jaPQR0dBKHi6HVdwrF/ag98t1LERIr9x0TWwNf5DXftJEBvwnDEBug0zN6xX2EVP6Bnc5s0GARG1CDrZ9808w423J/N1B819XWrN2zBN0jXQT+028syavEj3j6KS1GzZyxqtROhZkVfJMYhx0cshw1aDFCM3vDVbJPL3GtrkCCqQKmwJEYPItZr+PHOi14dI3Fcs25Acnk0VEppDnbLc91L4a30UyszWozsiUouy96xLWY4gBNZT0FUeAzJohnfi3I9pqjOkJaW70V3nwPCnjvC8hLUmQdZ11rMmh6Yx+FdYj9h/K4F3WfJBT0ffJdJ14Xf+a0eheFeATjAImYriGUmBk5R+OOaRINqFWd/z5SoYpWZXf34im6PrBWu6f90n+CEnTGqBNCCNEL1hPCo0Rio+aqU5p4JgYkIUGMfyncnxZD+Q4bWRJVbAOCQzMHq5GjUKWMvW62jbsSg9xYdFPAS7EHVz50g0cPKxY2XOhA1wCXHS46Syo2pDjEvoTQ1GaHwXyfqowgJDUpqmmNHupkWiul1VfpHl64/h4SC0b+g7oU779JkAOPciF4XBj2n3pJOBoJkBw45B/rw5v905QKJg4a9CDDLAekBhy5Z576Z0zOJVL2ov75po/nJNQaOc5dr22fkB2/8h0RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(83380400001)(26005)(2616005)(36756003)(86362001)(41300700001)(31696002)(31686004)(6506007)(6666004)(6512007)(478600001)(6916009)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(5660300002)(2906002)(44832011)(316002)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5IYkVKRHlRRC9DdUtXa1c0aEpUN0xGdkx5OVhmbSt0UU9NT2xEdXJENFpu?=
 =?utf-8?B?OWVGajBXRm5UOWljRmJ2R2dONHFDek5XOStLaXlXbUhUT04zS09laGtySk1G?=
 =?utf-8?B?YUUxY2Q5N2ZhRjE2bWY4SEJuMGFEbTBTNVpTVXJ6NVVJVEVKM0NvRVNWcmlw?=
 =?utf-8?B?RktKbTA5cmI3K0d0akNOZWVUMnNYUGV1RWVsSlhEdWc1a09FUTZPbE5NeUIx?=
 =?utf-8?B?R0kySEFQZUx1Z2s5NFJTOGpRSEpjcVZPbUtlcjlwdTdUbGY3d3BHYnIvR0NR?=
 =?utf-8?B?Uks0ZFNGTnpyRmp4WmtBWTVTMHF6N29aZXplUEI5ZWtsVzhUUFZuSXdJcHBP?=
 =?utf-8?B?NWFkb1dOcGo3UUg3RjFSYTczRXM0RUlnbTZYb1Q3N2lTamlzdmJwbUxTSXBZ?=
 =?utf-8?B?enh6OWZkamRxTUx0czc0cVd3TW5pQUsrdTNqaUI5aWF0QmdyL096MEFkemJO?=
 =?utf-8?B?cmtlYzB6aXZGSzh4SGx0dHdSS00rUjROT090MXBYc1Uxdlh0WDBMWmZWMlUx?=
 =?utf-8?B?MDhQTjBKTDh2clROOUlpZVltQlk0OXhXdHhRV2pHc2xoVmw2enZJbFVVRnVu?=
 =?utf-8?B?anpSYXE0TXpxeHdUZUliSyt5cHhTSDIwQXE3aVdtcEpHWXFEZ0FySFhKNCtJ?=
 =?utf-8?B?ZWI4eCs0aUFxOERkOEV4NXF5RFZNNEsyd213R1dDbHo0TEhxZDM0N3MrU3FS?=
 =?utf-8?B?N1grbHNqNU40YVYvWVpsQjdJa2xOQW1OUE8vRThaMTJUSGJNOXp2eGV4Ull0?=
 =?utf-8?B?MFBtSDFXcnhBZW41bG1FQS9lQ0ViZWdFWjJBbGhucjBSVnAzaGQvdHBZeGgy?=
 =?utf-8?B?aXhON1BuNW1uNk4zZ3I4cTRSY3lXRUJIS0x2eFVGdEFwaDVwTWhxQ2ZCV3F4?=
 =?utf-8?B?TFJsQ25RaDFSR21NTzlLN0dBRG5ybFVqbG9GWnV1eS95Y204d21OL0hicHVF?=
 =?utf-8?B?S1E5bUNITTBXWEpZby91YSsrR1FhN1lXbG40aVRxY2dVbzMwRytwZnhUQ2lj?=
 =?utf-8?B?LzRvd3R4clhSWFVoWlRGK3RhWWErTVhEYnpIVFMyTUx2OUJzVlZYWnYycFRH?=
 =?utf-8?B?WUFZcmJaNFliWEtESDZCUXpTcy9KTWFZa2ExeHFYOUt0N0tCQ0VTQXU2Rzkr?=
 =?utf-8?B?dVBYNnU2YlN5VlN3ZkRiRTJsZEZqVFpDc3dEclhRcFhSb0UzSU5rQVVoWHZZ?=
 =?utf-8?B?ZmYxUDVBS296cGpBeXhDRjdZdEdNRkdBemxrcmRMZGM4OWw5anlIOHF3OWF1?=
 =?utf-8?B?bXlENXhzeUpCTnJTWEdtNWVPcjZib1BEc1l0ZmlkRWl2UW1UQVg2Z2xMZWFO?=
 =?utf-8?B?aFQ3WmpBWk14YityOXUrSTBmRXFyNzkyMFVHTzllNlBnRjJpZVZVZ3pWdVFr?=
 =?utf-8?B?NG9Rb0R4bGRwNklaanF2K21Fc0JpWG5rQ2hydGZlbUFSYVM0VnI2cmlLZXZz?=
 =?utf-8?B?MVhoUGpKa0p3MWw4QlFFQ2hVVVNiU2dMZTlhQ3Y3UFRtTUxlSERDVTNqTUhM?=
 =?utf-8?B?czNYdU5ubGhlVyswczRzZ3Q4ZUVPazlObXZ6YlBZYnVYTndGSmlCM0g5TVE3?=
 =?utf-8?B?TGhYb1FoYmNnNVJUNEM4RGZBWG9sNjRoNWdPQnhTTC9NejMrUlRiZmhlNXkx?=
 =?utf-8?B?Mm1tRUprQXhYSjU4QTBEdzdlZVVhQ3lXeldlS2Jjb0N5OXZqclhMSFJXMEs3?=
 =?utf-8?B?V2Y5NFpjYlZZaGlQaGpORGQzSkJZc2ZSNGNBZlZTTDlpOE45blJVZTE4dm9U?=
 =?utf-8?B?TFIzcmFVeUN0eW5udEJHSlRTWFVYdDllT0tXdEF6T1Q3TC9LaThuOTJxbGd0?=
 =?utf-8?B?LzR2VFFFVmFQVG9ZN3U2cjdiUGtUSFdDcENKSGc4ZElyYy8zMWtlYUJEaCs2?=
 =?utf-8?B?emdpcG5YaUU1YW9IV29OWmlVYUVWT0RIUFRtanZzWDlqSlg2OTZLdDBGdVE2?=
 =?utf-8?B?clI3MEhJZmg0TWs2ay9QTGJIRUVBLzRXcndTbTk1SkZiY210bXY1Ukx0aTRy?=
 =?utf-8?B?VE12RTUveW9aZ3dmTUVsdW14TUlDSlB4SVlDS1p6ZTVPM2pCbHZYTkp6ZUMz?=
 =?utf-8?B?OWZGWG94UHBiMEhLOU9Ra2J6eWtaaUF1b1ZSN0lEbUx0SXBqRS9wNGNNZ0d3?=
 =?utf-8?B?ZDg5blVvNDNvcFErYlEwc2pHbGR6ZVVOQ3FYT1VlNkNYMVdROUxTMlBtUENi?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2c6400-3384-4508-4593-08dbfbf0ad0c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:32:12.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SvcyiOBUwalTCgfGq5wOwCg8pYmrBQg8pfVFVRdr2iIG2oT0/MBaxG+A1fOPuGfYE09qU4ZgpCTSRV8RFzqHe5dlVWFtHkvRvFuOPSUpM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.23 16:15, Heikki Krogerus wrote:
> On Tue, Dec 12, 2023 at 03:41:35PM +0100, Javier Carrasco wrote:
>> I wonder why then there is no general solution that does not force the
>> driver to be built as a module.
> 
> Why would you need anything like that? Are you saying that even if you
> put the firmware into your ramdisk, the driver still fails to find the
> firmware if it's statically build? If so, then there is something else
> wrong.
> 
The firmware is always found unless the file system is still not ready,
which is the case on the system I am working on. If the driver is built
as a module, the issue is gone as expected.

My point was that there is no limitation to have the driver built-in and
no documentation to reference, so anyone could stumble on the same
issue. And as you said, this driver is not special in that sense, so
other drivers might be facing the same eventuality.
Am I missing any existing documentation for the fact that the firmware
must be put into the ramdisk or the driver must be built as a module? Or
is it only based on common sense?

Anyway the next version will not have any probe deferring and only
return an error if the firmware is not available.

Thanks and best regards,
Javier Carrasco
