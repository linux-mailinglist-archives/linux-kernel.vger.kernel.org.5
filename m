Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A547A78266F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjHUJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHUJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:41:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82457A1;
        Mon, 21 Aug 2023 02:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOpBx5x6vaEaNZuYroHVOoNYKFMIgn7J649gZpzbcea8l589N8VOp/JX/91ERr0dcfw3Qd7YKeE++CSo/p1y9zJlPvIRefmGeoz/PcoQp2ajbFSzsSBLw95iruBToDMkhs43hHfbv5ODvTGtEqvPiqAKnRnXr9Li1rAhY/mmg9+YScX83hFaMsOorfqGhgzExS5ia5UHDMS9qeY7S5LFWCnGxoW6pkJmXn99ztXEp66h4dHeDv4LNYpR3m0Kr9uee89i4m5maWzYMR6hHsEzJDIODY+FcQ5zbM9QgkbEgKBHoaHA/yxKOUSbAK3jG6Dc7gtC/SvnMR1yDKSH3BIDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq7eMjF4ZGGCazPdralMiH9OB1al8Oug2K+FynbyyDQ=;
 b=Alg3JKAElGQTn9Zwa0cqQN+tsKvksTumQF+WvXyvsJiWOZW53r3D8MFAqsGHDaBw0JzSSNWuUAbuF7yjOdSB0UuxFrCDV+dvwByQOOpOiHhyfVgILIXr0IKX/uFrJtyMLnDRp1PtujU4EQMiuAa/8yt6LMujgPawttpV4YBk2nS/9C3b65rHuAHK2Lw9icVDTf9/I1NrZNt1cEb8j37pktSWe6UitxHyuAjnsvcFFQPuoEYw8YApdHdmqN3vRYlTRrKmAdlOlaDpANRQJ2N+bq5bIA3Uf4OvNaG6F9XBgTbzsLVWF0jzEhAwW3vVcuNSyH1PVb0bdpsFIFzlSu4kwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq7eMjF4ZGGCazPdralMiH9OB1al8Oug2K+FynbyyDQ=;
 b=zzL/wv8kwOEFXCpUeapIAJq/lfael3vpzBy33B0VIuGwMH/6PFCdf9t78jI9pEZ2o9YkaS/xEoq4Drk6mwl7e13X/pceNNIflXuGpXUvRqijPcrsqaBWATnZfWM1V8kSSAFFgmYJxyMYlygVGUZ34HOxsFpvTkzTaidE5TOyd0IKcH+bkE8opPbS7lQuEkqINToAerEtrnCtmEdlz3B1Ysps7EUKp+7lbJyGZjSAl7ody90wEIo6O/7O5AYBmylrJox1aIqwy9u6mphID+cWq0MTMlT4j4Kwjl5D33EyPngou1zh+/UwccNEI8eKe5vgFxYCdK5cdG4omFlgkJxWPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by PSAPR03MB5751.apcprd03.prod.outlook.com (2603:1096:301:84::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:40:28 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 09:40:28 +0000
Message-ID: <fa2aa42d-9701-6d09-1a0c-9e7d18f83b5c@amlogic.com>
Date:   Mon, 21 Aug 2023 17:40:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] dt-bindings: power: add Amlogic T7 power domains
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230817071148.510575-1-xianwei.zhao@amlogic.com>
 <20230817071148.510575-5-xianwei.zhao@amlogic.com>
 <a2e18e03-a50e-897a-b599-f3b6bfa6af88@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <a2e18e03-a50e-897a-b599-f3b6bfa6af88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|PSAPR03MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: a531c7d6-4cba-46a7-1ef0-08dba22aa6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJWubfNzbl8dHY8FsoSpVv+zwcYqJq1IL3yhUQOuuyi2sFADIeKDIPfMhz21zbqnRaL35IWG1mPci0BwZOszlQjteUiA//6HLyoUVTRERbWgGQd0iSWPM5WgLc8uejQmLnjZNW1+2EtT2s+tBwpYny8MmBFPxMql+iCqGHM8q1MaH/VxOdBnLgBtMBVczIZthzkx11/IorgLrgBJSwE7ojZVIb/u213SrrzuL9u+LIs/6y6WRzTCViYOe5g6UuglkZ2VCizcw74GPjttOI4r0iaRpWeZEymDqeUb0e76Ci0DT71LGEwwHdMPqk0ulYoGQ+AlDNROy+VV4GSC2V1zZTDU0M7SaDHZepKGK94rXJ9Fh8ZGymNCfdA/HH8BiF6/wG8AEYUN++T8M43sE8mwpu26sTLR0pKlcGkN/6br98HrPEyg0tf1EQCUTL2IpbURGjMHugZ1lDC1sHEU+RP+pW8nKPx+Tyl4m3wdxiTCILbiTclTGYJwXEFwJv7LLlq+Y7X4h8/n8vopbB/5ttsh3ps2bbCxBPynKd7+vUZWkm5o2ObrKuPJ1FMKS/LMcTpwH8XbjiAclg9b0YDWecI89W6TVRFl6vtppfMDT3kwsrF+gn3cabvIBuN6kmNR3EifELn9xn1TVDHwULZK5gqJIDiT02K8TXaiIGDrEf2CXlLK4lOSmkSZH9N807IzHJoAqTrUfBTPHCwDAk33IrBC7peRWd1RJWW984Hn6ciL+MI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39850400004)(346002)(451199024)(1800799009)(186009)(478600001)(36756003)(41300700001)(6512007)(86362001)(31696002)(12101799020)(6486002)(6506007)(66946007)(316002)(54906003)(66556008)(66476007)(53546011)(6666004)(5660300002)(8676002)(44832011)(4326008)(8936002)(2616005)(26005)(31686004)(7416002)(4744005)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNZRmVLZnc4Q0FkNExQQStDMlpycFBpK3IwMS9OUWQyL1JUQkpXK3BCckFi?=
 =?utf-8?B?U0xrVTdCVG4xMW5TL293aE9FdEFTa1lheFlsOU5uQ3gwalZMS3pZSy9Cb0w0?=
 =?utf-8?B?SDY1U2s4V2Z3Vi95UFgwb0lTZTM2MDZBKy8xdHpjME9Oc0N5a2VTWlNFMWgx?=
 =?utf-8?B?YS9tbkErajNBZlUvZ3ExSDg5QkxRZm5tQS9FQkxCTjl4ZnNiTDNPb1M0SHZr?=
 =?utf-8?B?dlJzVXJNaVE5NzYxMG5abUkrNlZVZ0Q5OFU4SDN6KzJDNmFYVTdaVHZWUWJn?=
 =?utf-8?B?TDY4cUZKcHZLTHhiOGhNcm1RMkp5M0k3bTJkQUxxQnIwVjI2cjNPbnNHd1l5?=
 =?utf-8?B?TUp0SmljbDVIZFdabzBSeUVMeTUrM1NpOEVBSERkSWkxTjJXd2ZId2xyeGYx?=
 =?utf-8?B?ZUo0aS9vRnlPc0ZMK0VxeEZjUytOcmMzd0tTMWlEU280T0dNWkRMbEFWQVNk?=
 =?utf-8?B?bVZFdWdHeTJwZmxnRC8xbXFYY0JSRTVMZmxudWcvQm16U2QrcHhGY1hUZllR?=
 =?utf-8?B?SGJpZ281K2doclBBYUFkWmppS0tDNDk4RXAwRTh0TTZFQlNraGl6R1FnenNX?=
 =?utf-8?B?WW8xS0pka0tiREhQOXhOdnpJZkZSbEVZM21XMkpsTVZZb2JhcVdOeUIrMW5B?=
 =?utf-8?B?ZGdGMHFWMzd4dkV6eUhiemwwcHdXOUI5NFhYNXdZK3l5ZGo5a2luWUtZTGR4?=
 =?utf-8?B?c3hhc09uaUY4OXBiRUpyclZ5L3lVSmtYSnVZQjZYcStjb2MrVFFWdllBa0Vx?=
 =?utf-8?B?M3B5K3Z1ZGpyZ3lFQ1NwWW5CUlZrbUJ0ZnNBdkp3ejlUdUV3Ty94RmQvU2VG?=
 =?utf-8?B?cENpRDBzNU1TbTZMb3RtUWtsUi9rS0xWbVZ1WlRCRFRoMWl3bjkreVlja2Nj?=
 =?utf-8?B?ZjdBRXF0UG9WY3pvTVBWNnE3aDRUeVRXVHE3U1N1a3A3ZlZyS3VhMHZrZTE3?=
 =?utf-8?B?aXdFSjVHVWNiSlI4MHFTNHlYR2FENytxOVZrdEc2M2QvYjFPbFhzc05YK3Nk?=
 =?utf-8?B?K3FUT2lwODNwWkx1aTRtMkN3eHFHeld2Z21SMkxMenFldHpYejdlcldEc0Q1?=
 =?utf-8?B?TnphdnRRdkhvaElhUndIT3dadkFCbFp5eUZ4Q3NDUGZCV05FdGNhQUFhM2dM?=
 =?utf-8?B?RFoxMEJjNHNCbTZyK0ErQzlTVHRFcXVHUjFuZGJTUG1zN1FFeTY4bm1TYmRZ?=
 =?utf-8?B?ZjE5V0JSbDJaREE0VS92NzZOdkpqQkh3cGJjdE1CaFY4QjkwQjlyeDR1VVdV?=
 =?utf-8?B?bXZ0M2pqVGZrbDBSeWludHhkdWd1VTJxdFNtb3I0OURCaWFlQWNDb0pubnE5?=
 =?utf-8?B?S1FuWkVJVW5tazROUDVWRDZBUnFIZlZEWHBvUnFiNlJOSkRzYkVieXZZcEdI?=
 =?utf-8?B?WkJBTTJZRklXVjZJVHIvV2lXTVkyY01oMTRyc2hISE4vUWpwQWNINHh4eHA2?=
 =?utf-8?B?azZZcjZ6aVZ2SU92RmpBUmZMcmtvT3VNamVTUEFnZ3ZleW9sYUd1UWJkaDh4?=
 =?utf-8?B?d1ZvMFZ6TWlqQUM1ZDZlSHhzKzBDVkhTeGpOTXFlQVNvU0hzTmx1RnFPWWtj?=
 =?utf-8?B?R0hVL0pGMkJjTWllRTh1bkRzYUlPTmttVEN5T2RLK3l1RFBtYVNBRmJib3Fz?=
 =?utf-8?B?WVZIQWFlbys5b1JsSUxzTm5KZ3c2eldkandZaEduOTgrQUZiR2JSRGptTWJI?=
 =?utf-8?B?YzVnU1dsbW9MTzhpSTBKZFYxcmJLeSsxSHErZHJDOTRwZHJsODVjSUJhL0M3?=
 =?utf-8?B?OUFhTVV1U3pzQUw5Mm14djlzRTVrejF3VEJLV0FwUkhiRDFkSVQ5dkNjblZN?=
 =?utf-8?B?QVg3UjRveTJuMlFGc0xFNXNGaEF2T0ZsZ3hIWE80ZHZjYWdHU2dBTUFoMFJP?=
 =?utf-8?B?NWNuZnJZVi93VDlsYWw0M0pFL2ZZUnRLV0xHVzVvNkx4ME5RMlZZcHhaR0E0?=
 =?utf-8?B?cm9Fb3c0NnRIdWwrdlp0cE0wS21rWHZWdisvTkVXdTZyNnc0THNoS21WY2lo?=
 =?utf-8?B?YnBvbFFndWlTb1NDVW1pa1lheldJbHlUNFhLY3A1YVErR3hMc0ZxTlczZVdo?=
 =?utf-8?B?YUR4Zmw5Mm85d3BBTStscFZHNDZ0RHRzK1hmMkRTRWh4RjkyWFQrUE1ScXJj?=
 =?utf-8?B?Q3gwaUhTZXNxS000WmRCcUM0aENJSk5rcDFHaWJ6ZTR0QkdXK1J1dnBtNVZi?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a531c7d6-4cba-46a7-1ef0-08dba22aa6db
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:40:28.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEj2LFkbHykfjeL7u7vCtVjHvBFFJjmI2jPyqWSDYOfKzr5NDSqvAbZJVuRKG7YuVAU3lCfR7JcY1S66Wfw5eXBGjjbEvunQkpz1afwlesQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5751
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzystof,
      Thanks for your review.

On 2023/8/19 22:20, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 17/08/2023 09:11, Xianwei Zhao wrote:
>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
> 
>> @@ -21,6 +21,7 @@ properties:
>>         - amlogic,meson-a1-pwrc
>>         - amlogic,meson-s4-pwrc
>>         - amlogic,c3-pwrc
>> +      - amlogic,t7-pwrc
>>
>>     "#power-domain-cells":
>>       const: 1
>> diff --git a/include/dt-bindings/power/amlogic,t7-pwrc.h b/include/dt-bindings/power/amlogic,t7-pwrc.h
>> new file mode 100644
>> index 000000000000..b7a13eda563c
>> --- /dev/null
>> +++ b/include/dt-bindings/power/amlogic,t7-pwrc.h
>> @@ -0,0 +1,63 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR .*) */
> 
> This does not look correct license. Use one recommended by checkpatch.
> 
Will fix it in next version.
> 
> 
> Best regards,
> Krzysztof
> 
