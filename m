Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0920C793724
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjIFI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIFI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:27:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416FCF0;
        Wed,  6 Sep 2023 01:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDfs3tu6aHrSih8A61LbpArqJOrqXLqVxnc1Xj+Socn7zPsS1gw8w0LeEnWfltI15Q7gBalKB1bu+BaP41MZ1FBEhCvUxrmP5AEmRXQFyYru+QV4zNXKTtPN2IpV2sXTuO3aa/9khbAiC8yFzU+VigpX8sCyuRuSyM12yYA/qlVaG7GPymImw2ynPcI3sfFLTKu142A1KIM20FI3qBSZE6J+U05wIMhQxp6kFBbYMSxgLt4ZXiY7A4wThe4gJo4okEa/j2yJ9VHUjxn+Ch/iOIrtvAvPpAJC9oPNbtCLxwEYpY2YQ8ye46oVB4PZi84JiPsZXYATJuFZspMdz3Mlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w9Y/2KMX7oeALiiigJl7dEt9GKHFB+sp+MAYzPSQNs=;
 b=U40txCE8isLSOwQ7L4Fgi4I0YHB/iQR5lgr5PP7wIZCLW/iKeujDb8V2RKRn2s8DVg8aWksAm1n9Qb7SJ9vaW9qGmiU9s5PZoJDDdOJIy4+udvWu0tIQvNNhU4qvaNAduhdUNsoSF0lbnh6663p/IZ/sq7Fe23lPjBr3GTWnM1APV07BkscKYPzlEhakM8bR78diM06XXvDi+EgXnHLOtDxYVgEKRH7g3EWlkaWmBadA5Y6G4LIxsoM/Ah26FXyTyuX2fw5VN3sjKt2aHkp0/xY44r7ZUmrv3uaZiZpcPqKIJx+uPenfoCMTwSDQ26LyZPjB49ymi+4vrJm4uwmKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w9Y/2KMX7oeALiiigJl7dEt9GKHFB+sp+MAYzPSQNs=;
 b=gBD4EctrGAHbA4PyNzyRNGyjnNm5zDMni5Ev85fCe5Q3jYyhogHDkvTdpCddzvUeGZGCwC/ZwW1/zqHpL/TxyoGVjeKAWpb6vQfDtW8yL2r/jZ2A3ZrAxGmu4U9nIwHC/Al5Z2fpKVuVaKtJBnibhP8ipnjKsSgpPZNN9ZB4+eqalGgiuYBnzFYnh3uNAiyfUlrIC+4jv6qFi8X3OU2v38s4hS3y3rdDkm+t0MG76MiXyqA5xjFciHALM7yhQvAJEgFLf777lt0+bnO1HFB0O5PKfBTcdYiz9A1PsG3hCpweTFolSUdJqjuvU23pKDmgZk6Plz5/LZEG3QzQvkiyqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:27:14 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:27:14 +0000
Message-ID: <fc297c1b-1d7b-9f22-ca9f-16d288eee5ac@theobroma-systems.com>
Date:   Wed, 6 Sep 2023 10:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
 <20230905181402.GA3673113-robh@kernel.org>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230905181402.GA3673113-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e30b92-431a-49a8-8fa9-08dbaeb312fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lraCYAckDMKVWcFxRXA6BDK+jXvtGyGdJ8I/jMpBCd1pCEAkUCC1iAQKwGHcqTvqNA7jShyUmNxxDGExz92Ow2jzpo6a0mmePMR5bYAesyG7pcWEE8rffD4qODgRKDbflwC7t59YGfXA+tIPY6KGAgfkLVwjSJG4iysrTcTjrQs8fcBma4OFl9QzgNEwDFiBDxZ9xIF+M67BpbwZjBeeA5ABDzKs+kRsLKWILyZrMHe0mq3squjHXvcFvcvsoIfD5IckcdRKrzqL3toi1aG62Cl3xZCrerelIg1ksL30GBpWK/1lbVnEVW5hzHWHrOq0PavNKIV7H77s7YpI/g5fnvEYt+QSeTAJidvtJ5Z8ZQ6KGmxTTXnVwQNSplg7eDpZtYwa89SFccibhdab4fOZBXCn/1jLClrF7yiN+URnKbqJcGzRi02EeU1ArayINxOJE+v51fiMv7h35kluKiMPqLvGgEY6cuHUy94YVPbIQZ9/edjtbcg1nuxCw/AQn+FCEwlLbc7lTAwF+GQJe1KYL0Ilt6LkZW3uG8ngpj0bdY5buQubGDrFu+iEVuIVxUxsH0bUDAo+SyCP+3/QwdB+77zJMMlxlQlrxwNbnFjNI5W/T67rj8EHsvBm2Zvo7V6XxqoIMDMQebEfyKkxYoTfyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39850400004)(136003)(1800799009)(186009)(451199024)(31686004)(53546011)(6486002)(6506007)(36756003)(31696002)(86362001)(38100700002)(2616005)(2906002)(26005)(966005)(6512007)(83380400001)(478600001)(110136005)(316002)(66946007)(8936002)(5660300002)(8676002)(4326008)(66556008)(7416002)(41300700001)(44832011)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2xBK0swQVUvN3paZU5BTFpId2ZVUFJxODl2SEhUN2dERWZHTVpGVVpOSHIy?=
 =?utf-8?B?Sk1VTVplNkY0RFUxd0Q3MmxZeC83Nnl0UTVwRU5xK2Zocm4xdEVDdUZ3cXBP?=
 =?utf-8?B?RlAyTXloZTd3VE0vZU4zV1Y5TUh3eWtxSFlSZWVxdWhFK2VkbGp3bHlXMkJB?=
 =?utf-8?B?R0tOSnovRlFvWDE4OTd5cW9IQWo2OGtpQy96eFJnWUhobVJTbjdDSXJFMGRT?=
 =?utf-8?B?S1FxanhWMG1BTVBlR1k0ZUtqNnRZdk5MV0pQVGpleXRwcnN3c0VUdk1YaXp2?=
 =?utf-8?B?RTUyeXpSajd4STJjTDF3Si9uV08vUG5ldy9EMkhPWTN0SDhlOFVVdXVIUXZN?=
 =?utf-8?B?TmI5dzlIOFh5dUJ1dVhFQ2dUTElNLzNiMmlsS1B3Mk53ZUEyS0U2VnRMZldT?=
 =?utf-8?B?emY1UEU5emZCQnBwa0loTU9UeDFGcjlPZWF2WUJVZG93Wk52Qm5NNG5uYm50?=
 =?utf-8?B?U1kvME4zZmdETlUvZVRHOCtYZFl0ZWEwck1rUnkvdEl1RC9SK2RCQnhIOFIr?=
 =?utf-8?B?VUh1dFdRRWJmWVRjQ2xwOXc1THoxY2tOb1VEWW95dVFORk82TWFEOTlXa21B?=
 =?utf-8?B?NWJoNFNQOTM4MmZ1UkxidEJqUmtjV3FzelZmRjlvaWJYNG1qalFhc0F1Um9U?=
 =?utf-8?B?eUtJakRSU0luZGRjNnlyWGEwUjdFYmoyelJReGFUc2NlQVpuN1hzVjNQYUI5?=
 =?utf-8?B?VjlvK2YvSERhQllCUngzQmZTUTRaa29WRldOcU53YnBocEszZUx5YWxKTFpT?=
 =?utf-8?B?d1c3NWFremt0TFRaNUVaVFI0RzFzZEN3TlhXeExPTmo0Q2ptUm92dmdzRm5u?=
 =?utf-8?B?RWlGSU9vWWR3bkhxeDJKSkwvOGlZVDh5WlA1aXMrMDdQeXN6c0FVc01zVTI5?=
 =?utf-8?B?dXdQanladGMyN0dEZlowY0dXTTY0ZDBWa3FVaGdHOUxxeWhHV2R5VCtsK21z?=
 =?utf-8?B?c1dSU1ozdkY5NlAwN3ljQ24xVHZTWjU2d0llZXc3bXNNdjVGQTJkTkxBVlFP?=
 =?utf-8?B?TXIvQ3pLZUFtMkY3S04yY3Y1N1JFRXVIT2w0eFFRZXNSVFBjYWNEakh4SUNl?=
 =?utf-8?B?dElocit6dEl2NXFBNzYzT0FQMGZmSnlmM3ZpQyt2clJsNFhya05jUUhqRzEr?=
 =?utf-8?B?NlpsNkpvSHNqNUJjVFF0RTg2akZYNGhJb01lNENLbU1xdWoyUkRsYzZSaTQ3?=
 =?utf-8?B?OHhJWGJaa2ZwYS9XK3F0aE1ETFpzQUJmTVdCUWNva1ErdnVQeEI3bUxZVTFx?=
 =?utf-8?B?cytrTVlxUmg0a0R6b0tkSkJnbjRtQWRlay9OTUNnYW1ibDUvRmRDZDZBUkF1?=
 =?utf-8?B?ak9INmRBTVVhem1Oc1FON2R3cWVlaGszNU9JTG5JekdZejR2ZGJ1QytFeGRS?=
 =?utf-8?B?OTVCVnR2bExtUW9jU2tETENkVzZDaFAyT0JJK0NDbjF3T1BlelZGdEc5MTZ3?=
 =?utf-8?B?RXF2eTFsTzNKZ1RteWNwRU5kTkJLbk9KL3MwLzhoazFlckMvdHNlZE1iQlBI?=
 =?utf-8?B?RDR6VGJQeG1BamVMN0NQK1RXaW92SmlmS3RLeVY2TUdJR01YNkYrbThPNWVL?=
 =?utf-8?B?UFQwVHkyaERCRUR2ZXNEMlk0MHhjWlcyQXdTL1lmaXlQODJ3WUhxWmxWY2oz?=
 =?utf-8?B?NmptWVRPZVptMGc2RzFHUUROaElaZU9SNkZ0SFNaOHlUUzUveU5TL0xiajQ3?=
 =?utf-8?B?MldVNWlPZ3pMZnZXYVlnTjdXMGdMM3BGQjd4empMS1N5RmMyUTMxUkJUVkxQ?=
 =?utf-8?B?UFM4dmZlZ0hMVzIwYk1Vd2w4bFRod0haUWFxNWR1SjdVdkUzc2pJZWZETHR6?=
 =?utf-8?B?SXFzRW1abmFQWENteUR1RzNuTUNRVFBLUmUrQlhHQmhBcHI0d1N4RjJvcGEr?=
 =?utf-8?B?VUpucWN4WEkxVnhKUTVKWlNZVlg3OWhNWExKcEpIVTdzM2xKRkwzZEx4Y1Fv?=
 =?utf-8?B?QUd1L0FXZXVmSTJNU2w1M0JRZGZkMHZTYkxucDJTR09lVnRvUnFrZGlnaml6?=
 =?utf-8?B?RzNEWndOVmF1RFJTczVZOUY2OHM3YnBtcTR0azNCMjhEcThrakI0V3g1SmQ5?=
 =?utf-8?B?OWVlUDM2YnZiblZEZEhxSndQMVJvZHZxMTYreWdaaklFTXhOUWtxYzlGWGJZ?=
 =?utf-8?B?SWN2K0QzcmF2c3hNYzBXMlAyYW1CdjVpeXZMVk9yY1ZZdDhqL0R4Y3I4Q21j?=
 =?utf-8?Q?uRIAe2Q92WZxTMWU9fsTauI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e30b92-431a-49a8-8fa9-08dbaeb312fd
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:27:14.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/GI06arJJgatFdofMMnA4ua383cjlt7iP+uqj1OKlC6LjtoZfXZPBMmf+Lp9xL3DkVgSNr7I9izfiI0z6LY6uOPt4nxI3XTWBcTZpirb2WIZH5FyB3rvBnIoZrcY60+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 9/5/23 20:14, Rob Herring wrote:
> On Mon, Sep 04, 2023 at 01:58:15PM +0200, Sascha Hauer wrote:
>> Add rockchip,io-domains property to the Rockchip pinctrl driver. This
>> list of phandles points to the IO domain device(s) the pins of the
>> pinctrl driver are supplied from.
> 
> Is there an actual need for multiple IO devices with multiple pinctrl
> blocks? If not, you don't need a property, just lookup the IO domain
> node by compatible.
> 

Yes. There can be multiple IO domain devices on Rockchip SoCs and we 
typically have only one pinctrl controller. Each pinctrl "pin" (for a 
lack of the appropriate term to use here) belongs to one domain of one 
of the IO domain controller/device.

However what I don't like here is that we do not explicit this link 
between the pinctrl "pin" and the IO domain controller it belongs to 
(even less so on which domain of the IO domain controller, which to be 
fair we do not represent in the DT at the moment except through a 
phandle property in the IO domain controller, c.f. 
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml#L84).

Cheers,
Quentin
