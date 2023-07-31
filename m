Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95127769135
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGaJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGaJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:12:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F7127;
        Mon, 31 Jul 2023 02:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMaos6dHsC1F0eaKiCyKQd5DeKqxLVVVB1dboFCQgGmsQzO2GdF9uZQXlsUY2pE4/bQ440cLL2nVC/blQigAspUq+pXxoNXV5iCfpQdj62WCDc/llMrOxHiFayEQz7up+97uyTGTw3T++Jm/X/1yg2UrGWgn+4FumdF0nQlAPAU4ODd0kLn7/pRUnw++UqUOo35YPbSUAEe6r1XFDZE9Bf/dz6imAjelSXj2x+hLMFbWD5g+j6sPdkzOlXbyFDlkaKdGjghtq6a0r+BjaUsxFCxORDQmy0RXIa97XUBRp11QI/3DmoUVPMrWb+Q2ZQhtC9mZ0dpe7c/dypKNCOdamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DrdkCE8uc7eXBUrMmiVK18vexYtcppt1MJ1pvXbxVs=;
 b=TbtAECj4sci4QM4gn/wicau7atScCNSZxJcBNyz3R8DiNNC+wJx2vuUzBO6LKdGEGFO+QIXA/zL2K2WUlvA46ET+lsm8jktY57MPSd91xbftL8i03fBwRtcCrMpGNHHlOBwVzhIWTOBeMam32T35lz+CIQpuXVLBuT/kevUiAruEWj3crgFEPfHfMX09dTDAaamFGrtJB3ACqk9F+SaYNq2Y0qH5LZYlxFSppgnyYU49Ty3qzpH+43EaoqTzl4rNUesGzrZEsyW7NHKMmgTAmNUyI8PlRUaSVRzgsnXUQ7GSQoclbVOW9yPaWPUZO9jSyC/Tw9MNTHZKF4WNQVVEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DrdkCE8uc7eXBUrMmiVK18vexYtcppt1MJ1pvXbxVs=;
 b=LDc0gZjSCmWUC6HdVeXPx7w0wyXi7X9ShDPazKjj4W4foBykgq4tYqjJgdBwqyXe8AMWUbbpmpHDGUWHySQpgQ8LlvKOrbibKks1DjAE7KoZrf5SbhBmpHvNq+7b5uhPunykU8UlE8prxPXatOiSqCo9V2l+usFjnhXsN3Ix9wCb9hs0tW7RK6EiCoRLQHIsbBFusUMcyFxJOxn74oPwEjZn92MZeCuEsUGghX6kKKkB86AQy1Ldw8Hr1+rEI8UTzoZK1AZyPA8fBb2avkon1p7phaVRhi3SB1hJQy2tRdDrT6KuRKLCjwzHyPUgkXkgoKGxFNdbWIYWsNkjyl4Gow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
 by PUZPR03MB7188.apcprd03.prod.outlook.com (2603:1096:301:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 09:11:25 +0000
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::b766:873b:8652:23c9]) by TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::b766:873b:8652:23c9%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:11:23 +0000
Message-ID: <eff61afa-8969-7f22-baf6-771347860efa@amlogic.com>
Date:   Mon, 31 Jul 2023 17:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
 <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
 <68b7d772-8dc4-a781-031b-ea33dae41751@linaro.org>
From:   Zelong Dong <Zelong.Dong@amlogic.com>
In-Reply-To: <68b7d772-8dc4-a781-031b-ea33dae41751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR03MB7240:EE_|PUZPR03MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 6640b021-2c41-4ffe-de89-08db91a61c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTtYmAStzlCVJnKxWdsHFjyNabh1+Or2UFBIjAm8xYT/XZk4qCNMcEfe7zkE0I7dBSDRY9VpMfT56kZL2/X4MxqEoCl2SuGnfsUhfmJsbfLm6pVKz0MsQDdwiA2VzeNPUc56FWWTZo7ueNFqV7BCrTz96eDhAlYO75iy0gp0jNxjc2HrAzz+u1+lnANOJBmOygu2PFkPQx3s+ju4k6EMnr6k8yEPJn1iY378bWK2wxwBg3BygKp+9O+6eYtDD5Gd/S1rQ7ptfZc9wXDhbcWBUX+r2e6RQyzlvie0GdGdxK+DkHCK2CAareakstgYneHFV7ooJh7jRXcHg4Zr0rvsBblOuiwVb3yjTCClZqX0vkGPXNr4MfJ1ZDfXubDekjKEnwfBPosW4eJCNDx6pSL8yf7+IQ/TrFZ042jfASH7Eqso4YUt4TdqmsAGzTEBAWFIBEI1CN8MvcJiXaHvnF1UJkZL90EkOfdaA2HoXtN3oLw1t8PLQFcRvyUkVcW9KiRAoMzbtuYvsk9tDtbX41Px3FoH36YMEr6gsTbA6WWIO24r+G98IQzWI66BnNoJ0HPVhnW/DdW878/zR2Cd9CjW0nNJx20LNstNZqlmRJbP8mduzEyTWjdru2JLcTUmXfHT8pfDgZZ1/ovXOrp2ZSZfOekFETgBoe1uhC9iVodsHbCwajZvVSfMhYERQpkuy0KQANLgifxqjuFMiA57QoqBPtEbuudg+YeeftE5vicQhTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB7240.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(451199021)(31686004)(2906002)(4744005)(478600001)(6486002)(6666004)(7416002)(36756003)(316002)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(83380400001)(186003)(38100700002)(86362001)(31696002)(5660300002)(53546011)(6512007)(26005)(8936002)(6506007)(8676002)(107886003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkQwelEzOFlQRzBXSEM1b3dsaE9jbm5xbnF3Zi9Cd1dIbG81SW96aTBoanEv?=
 =?utf-8?B?eFpEbnlNNkpvSTZUSVpaWW5RdFlhOHhqZmhCcC9IMCtnWGhHNFRobWJ6T1p5?=
 =?utf-8?B?eThWbENqVTRvWEQ1RU93WHBZSzRwL2pOV0RWVWI5c2tUN1hYdHQ2dk1PMnd5?=
 =?utf-8?B?Q0Zuc2hsY3ZxQVpLUjRZcldxOVFTdGY3RlBVMldjazlsVklMNEtjYmJqdUx6?=
 =?utf-8?B?dk9YVEVtVjVXZnl2MEdMeEd6eElUMDhKWlZCWld4aExGY0JydTJVOHZzRWIx?=
 =?utf-8?B?cVBkUHc0Wi94V2N2ckdhNXF0bk50VjVLYjNtN2ZHMzlCWUdlOFhiVTdzZ1ph?=
 =?utf-8?B?NSt1b0t5TS9YU01BVHhNV0tFVThLM0NoWFZCTDFzNmV6b2VIbmZ3VnNlUTlE?=
 =?utf-8?B?Sk0zaTdPR0pjWEx6UzE1R1p5TENFM1JVYWJzdEZBVzg2SVJtcXNqWW1WbDlZ?=
 =?utf-8?B?U1h1WVBKdnFOS3FjQmNEWnJBLzFWV1NjYko1Q21PV3hBNGZXUVdMaFprNmZF?=
 =?utf-8?B?OFBZekZpSWEraHdFN2t5OTRmQ0dRWFRuZU1lTzVYcXJSNGdocVQ3enRKdTZW?=
 =?utf-8?B?V1BMcGs5QWpXNlA3V1ViOENZQ2xQdUpEb3ArSDU0bUJCOTNhQWlyZ08zYm4v?=
 =?utf-8?B?OU5XN0dPaXpVVk5qYlV4dTdXWFZKNUtldVhoRkJFeEJKei91b0lobDN1S1pC?=
 =?utf-8?B?U1dVL1FZYVl5QXZ4YnFtT09JZFF0RTdpcFR4b2hoci9OMElOSjRpWDBSZWRq?=
 =?utf-8?B?S1VOQkxKT2dhLzdLNmtGM1AvamMrUVpqWVJ6cVNRMDE4a2tOK1FhcmhadDFu?=
 =?utf-8?B?b1BVM2xEWjdUc2tpLzc5WU5KTEUxNEY1Q1pPbkVsRHNSdnpPWU52MFp6R3ZT?=
 =?utf-8?B?T0tFMG5MWjJVa3VsQXo3RWRLRUlMOWdWK3QrdE1oSU81bmpuWlJZckNqa1Nl?=
 =?utf-8?B?UGhhWWJUWU5CeWp4bFVmWVp2TU16Sm1kMUJBcC9RbG1iYmI4dDhIY2FzK0ow?=
 =?utf-8?B?a3ZFWFBCWWRhTXc5bmhXMFQ5eUN1ZVNKLy95Qi8vSGxXS2xGR3BGZGR3amgw?=
 =?utf-8?B?VUlsTlBQdFY1MjRibjlYZmUxSzh2Wi8zUW5ESHhOY2pwbDAzTDFPMFJqc1Fw?=
 =?utf-8?B?enZ2K2hjQjc1VnZBQXE2aVh0ek9HeFo3Z3o3VVNDUVd4VmFmVi9YbjR2WXhR?=
 =?utf-8?B?VUVKcnd1Nm52M1V0WStTOVFFeFphb2tFcDBPMWhMQ3RRN2FVMzdZRG9xcTFD?=
 =?utf-8?B?WTNuUXNvVnE1bTFiMUcxbTYxYVJZL2oyMkI2WG00dnY1OThORm1EelN2QUEx?=
 =?utf-8?B?NEcvdFl0eVR2ZGVGdGtsY2VTdnJmQlhXZmVMazR0ZktBZTg0V0t0dnlqdi9l?=
 =?utf-8?B?VTFtcGQyQW5mN01iTmtLZ2ZpNEttUU1lUjJYNDZtSTBQQVVLTURwVFMxUzRk?=
 =?utf-8?B?bnVEVU5OQmpYSXUxZzhaM0p6cnB4TnRuaXlEZkRWdXU2UWI4V2M3dUQyVEl5?=
 =?utf-8?B?UUkreVc0d0N4RU95WWh2V3ZTMDZBOGVldWkrN3FFbzdPN2RpdVZ2K3ozL2hz?=
 =?utf-8?B?T0RTa24xcmpyWnl6UjU1d01oWDdPT21DdkJ5UGd1SjlzSEgwRk50cGVZQ0ty?=
 =?utf-8?B?enMvYTFWVFFJdzN2SXo1aEJicjlvZGI4TjNrRGZKYjE4RmFqTlRXZ3VuUVNB?=
 =?utf-8?B?R2kxMmFNM3BDbFA5QzJ6bVNYUGVWRXJ1S0xZRktXWGtUTWhLY09uMGpxWmh2?=
 =?utf-8?B?Zk5xREY3UmYvR3A1cG1FZW9ZM1dYN3FRRksvb29MbWlnYzdOSC9idmVpRE0v?=
 =?utf-8?B?eTNGc0p0Si9tUzVRempRWDMxNUNOMk80ZExROVNsVTJnLzBOK2pSS2M2Vm1Y?=
 =?utf-8?B?cThxbTlUQ0R3enAzMlFPeW5Geng5dDc3WFZzKzVKZVBxbFNXZzZPM1RoN0ZL?=
 =?utf-8?B?Zi9PYmhqTkpKWXpSZC95MVkydFVPeU9oY00zbjkra083UUxIRFl6cUJLenV0?=
 =?utf-8?B?alNIYnlON0NrdWpJWGFDbE85L0hxcnlSU2F2WmRqTlhkQTRTMDNldXFLWEdP?=
 =?utf-8?B?NjRiUmRLMU9taVlyRnU3WDdWRFFIQWtiZFdKNHc4V2Y4SDFmbDhSQmtabmJw?=
 =?utf-8?B?Nkxpek5sRWdDNnBqMnhHTmRSS0Q1VDhIbGtpekdoKzhoenZ5QnpiNXc5WUxR?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6640b021-2c41-4ffe-de89-08db91a61c52
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB7240.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:11:23.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88Ogvj8Df5pN3lXPpD7glwZq17LzaU2JuNPRkDqhy1uogB23ol3h7p6Lxx+/vLNiRwy7ANl8d5FLrd+4Q9I8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7188
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/29 0:40, Krzysztof Kozlowski 写道:
> On 28/07/2023 17:49, Philipp Zabel wrote:
>>>       maxItems: 1
>>> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
>>> new file mode 100644
>>> index 000000000000..d9127863f603
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
>>
>> Given that this is only included by
>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
>> moved to arch/arm64/boot/dts/amlogic ?
> 
> I think there is ongoing work or at least plan to use the IDs also in
> clock/reset drivers for all Amlogic platforms. Do I recall this correctly?
> 
> Best regards,
> Krzysztof
> 
So far, Amlogic reset headers are only included by DTS, reset driver 
will not include these.
Should I move all the headers (include/dt-bindings/reset/amlogic,*.h) to 
arch/arm64/boot/dts/amlogic ?
