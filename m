Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD977EA81C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjKNBJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKNBJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:09:32 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2074.outbound.protection.outlook.com [40.92.103.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10767D51;
        Mon, 13 Nov 2023 17:09:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk8n+mdfUyKurQw3kxOWRwVMEAO3GE+UiRbZ7N38Fp4GuVq/fdh3FC3Jy5hac+AJhvZKMo6BDi+7JW+o+v9QDwwJjlpJAwz8Q2jp3aU9gs24FLIj2KuCvOD/MxRExcnjxevVc/dEzWSjIao7cgq8Ry6v4S/D8e+lB3rwJZUqsWAKLDcxpozFKOMljHrQqm9v7GtyC0z6l5Z7Tb1A+7L94bDW+tzhRSa+Xyq0ElR4I8patbE/NYDgPxqGqAM7+OZyDw6QEzCjQOwwLF2r4M5EGP+2+bpunAN4o5L8dG+YuhNj0ivHWokVjLaAp1gOjTkDvYsp/eqbJNbv9LgYhqGxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjdOsaqtBFefFjJCKAcezFaKp3L5uHdfJ6RYOodcp2o=;
 b=X4kDI/CLkTiMgavVb7/iix6YmXc/HB7dTpFdQmNfseyg8Mtc1O8AKtKkquw8PDvuHEjC/hU/ge11P0jEsFDU58sGrcAreOiPSxPzW0uDi5jk+STRXDrw3jbFnzZ/olMyPJYTp/12ddnXSkT+CjnNbYAtd+QIO6MIJzRtTj9sALFvMh/m2JP6//In+OIwIYimPHfnpJCWpm/OsfRKFrKeDnKsOyzevYkwRySAvhBksdR/KcS+ca7lymse+oFjvhV2AmFD5WnkYKb7MqtILDDaoiMvoUQ1RaGW+Ice3kU8wBlTTZtbQ1fIIt/cpMtBgNcakzvsCEPfEYh112tzyAREvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjdOsaqtBFefFjJCKAcezFaKp3L5uHdfJ6RYOodcp2o=;
 b=XOyimdL3oUSkMhfFDcEuN2KgEFVbIS3/OrK5qcbAWIevSkWRMGaikz7xcmTcfeRRvIBQ/GdTZIboSyK4tT6rL8e4+i0PJoA1sSspq9azk9p5IuQboCI1NpeYUURd+LxxmKPHS2qajmWGbma7YYEefoCFX9cXDCUnV0Mv2xN8Xboz0b246p+SOPPvNLiIh8Y3OwA5po1fI0p2oyNM+13K1dgNQJgRdlyVxVAQMftuY9082Bvp8inIbjuhjIiIzLOrwHtiPwi5cqULVp3tu/W0ugXco8QmFHsplrr+4kCvqZI0a2DKu7NbSleBWYKg9kPtftN7TttIJBa3sQwj18vz2g==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB2474.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:139::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 01:09:20 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 01:09:20 +0000
Message-ID: <MA0P287MB03326F420E96FE3198C81C21FEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 14 Nov 2023 09:09:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
To:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49533EEEB2F7E8D93762DC1ABBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49533EEEB2F7E8D93762DC1ABBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [/sXPbWpfETNcYHET56ebrpKqazvuun7pDuRXeJ/pV3I=]
X-ClientProxiedBy: TYCPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::18) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <8b83a3f1-6bf5-45b5-972c-4c43757ea9b1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB2474:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ee098e-bc7f-4c61-8bc5-08dbe4ae54df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NYDa3dMOmCuw1bPemgudnMAKeWXII1ULeDySHKarxBIRPOx5LG2qL/EjCufux/SveiKjh4dbMwepdU6DLo+J33JntY7UK1zVArQ4xJ1TjJ5hUgEwGtxLdNzCHsKye3tmvM8wgPX7NIpXPArrRN4s8ShWn8dyuYzm1rChV8vcEU5jkASkcFoh9B+ZAN/y+XixZohaZ5Y4OyKFIe5Ws2pWuUSxSS7t4fdeRHq0x3h7Y4okJHkEkZbheiuvkkp5Zqiw+sr9ILslXm/i3cI6/UufIZSMp0CueKwF9fyuYt6nqVlj0DlEG+KlnFtSwPIfMVhr32Onc33rTs3taYj6XBDrSPc2br45WiTbdnslE8YSc3ReUZy8pmAa5VWD8ytc364opDz924UdzMmKmPXVR41rT/9WSsVkqN/DSipD7Mg+9u7kpfz32o6TG3COZ1YBmy9NGUND2lUDReAfND+wcKw9Vb9+Mz6JEII0mnz33t07J4AOqhKd88U9b0ck1QrLIBO0LT4QxaDOucwgeq8tqmEmMnXNoD4CJiyfrm6DsfvRM7PYQH0TCU+8f3PZK2DEwNbyxQvoG8h5kN/POpTSblczX13BYLhPYA8utKEBIue22I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlllM2xrNDhOZkNvQ0NVQlN3MFp2eFVsNE1SaEsxUDFmaDkwQ0FiMFhiRTJx?=
 =?utf-8?B?WSs3cFdLaDFIR3Z6VDhKSXljV05VV24zUUdlUmpSa1E5R3MyNzhlVGhPOW1r?=
 =?utf-8?B?dmZmSWU1c1JoLy9VdUxPMXlsemtSS0txWmJyVjhKUTJyMFdKeXR6NXA0TFlv?=
 =?utf-8?B?ODdqNzBHeXh6azRPekRXTXdPamVVcndpbzh5ZmF4QUxGandqRGhGRU5xZ2hl?=
 =?utf-8?B?dEpjVlN5SjA1VTRjcVhGZWRRaHFZTXhYaE9aM0kyTzFlSVZOem83c0Yvb01S?=
 =?utf-8?B?cVdQSE4wMkJIZmFKL3FySnlxWXo1ZEdyZUJ4VGFUaFNzZDBMc0ZWWU45cmI2?=
 =?utf-8?B?UnZDUy9Lc0UyWXc2Kzg1ZUtXeFBiS3RJaHVLTFpGRG0wamRIUVFlUkxDd3Q3?=
 =?utf-8?B?Z3dOaVZ4UFdUWG1GUDU5dGFoQnk1Y2FWSEJxTG0xQy92SmlnUWV3MHRqOXZy?=
 =?utf-8?B?amdMUS92U0dRVVRIdk1lcE1qYkNJbWM5VHpWcmM5Vnk0S3VDM3VvQjdmT3Ba?=
 =?utf-8?B?WXFPT3VnYUxoTWMvMHNlMmNUQmJMMlc3cXNDUHZzallpTmR0elllYjBSR1BY?=
 =?utf-8?B?U2pOWW1aQklQc01RaUFRenZPMXhBVWVscjdoZXp0eGdXUHplYXAyQXVQdUZC?=
 =?utf-8?B?MGZKazJrMTVrNFcxY3liWnltaWxTZ0pGR0tvQysrTXhKbjhBUjAvcFlhWjhl?=
 =?utf-8?B?YU9KM0ttUlByUllFWHl5QkEzTDlGWFRTa0kzWERBSHFPK2kzdVBJbGMxNWZP?=
 =?utf-8?B?YkhLRjY5aHFEaUkvNHJzeVBVOGM1aHFDblFQdVNwZ2NTWGRXVzlBTm9OeXRl?=
 =?utf-8?B?UVVEQTAzbSsybXFEVXlwYWlUTHRuVzRnbnJ4emQ3M29XZzVISGxyOEpYNjdv?=
 =?utf-8?B?a2N2cE8yamU1KzUwZWJVOVJKcDhwTzFZSHhwQTJEV0FrSkdWQ0pSTWg2Qk0x?=
 =?utf-8?B?WlFnMCtlRnE0UEJ6cmZkbWJJd1RicVJsaVpZcklXOWloQVFUNnBia2luU09K?=
 =?utf-8?B?YVRIZE1MQW1VOXZQb21ibzBvRGpURHN5dVJDWE5tWUw2elFHZHpYRDl5b2Zh?=
 =?utf-8?B?TFpJcjQ5MlVpeWozY0dPNVZ5M1UySDdBQWNoQmxSbXdsczljWFZ1N2dKbFVV?=
 =?utf-8?B?SUZkWVM2MWcrRHVLWEEwanpYWHJlVHF5anB4dHJCbk5aWENWcTRxVEtLR3px?=
 =?utf-8?B?VlhObmtVRlJWa3dRcy9WaHRiOHp0dXZJSlMyOEttM3NBelFscGE1RmVlUE1W?=
 =?utf-8?B?a3dXSXF4UTl1aUhwRFhDdE5lZDk4bVFWUWR5OEFxYzNLbnJBSTJzQjVxS01K?=
 =?utf-8?B?QmtTa1lSS3U4LzBrOEh6OUd3SWoxQWcydW4xeHZoUldDNHNBM0U4Uk9vUGQ5?=
 =?utf-8?B?TFNvaHpxQkVjeEhwekZSMzNzZjlCZmh1MiszVDlEMG52QkI3a0VVRVd6UzEv?=
 =?utf-8?B?Q1Rac2pybnlXZHNyOTc5cnB0MHRiMkJUbGh2bUFRR0FEb3ZWSnZkSEZBVnBu?=
 =?utf-8?B?N1oyMlFyVmU0N0EyOEs0MXViMEVjSFEvenRjeWl6WUFOTlJpNVZ4Z3laWHVB?=
 =?utf-8?B?clZHdUNqZWF1L0FQM3JObjI0T2ljZVM3am5jN0kydHpOM0d3NnlqeXphQWls?=
 =?utf-8?Q?oqdAmfvFnq1J9yJLOtpGBaLzaPt0nTOTJXyixY1Pih3c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ee098e-bc7f-4c61-8bc5-08dbe4ae54df
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 01:09:20.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2474
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/14 8:45, Inochi Amaoto wrote:
> The timer registers of aclint don't follow the clint layout and can
> be mapped on any different offset. As sg2042 uses separated timer
> and mswi for its clint, it should follow the aclint spec and have
> separated registers.
>
> The previous patch introduces a new type of T-HEAD aclint timer which
> has clint timer layout. Although the timer has the clint layout, it
> should follow the aclint spec and uses the separated mtime and mtimecmp
> regs. So a ABI change is needed to make the timer fit the aclint spec.
>
> To make T-HEAD aclint timer more closer to the aclint spec, use two regs
> to represent the mtime and mtimecmp.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
> ---
>   .../devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml  | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
> index fbd235650e52..c3080962d902 100644
> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
> @@ -17,7 +17,7 @@ properties:
>         - const: thead,c900-aclint-mtimer
>
>     reg:
> -    maxItems: 1
> +    maxItems: 2

The first one is for mtime and the second one is for mtimecmp, right? 
Recommend to add some comment in binding file to make it clear.

Chen

>
>     interrupts-extended:
>       minItems: 1
> @@ -38,6 +38,7 @@ examples:
>                               <&cpu2intc 7>,
>                               <&cpu3intc 7>,
>                               <&cpu4intc 7>;
> -      reg = <0xac000000 0x00010000>;
> +      reg = <0xac000000 0x00000000>,
> +            <0xac000000 0x0000c000>;
>       };
>   ...
> --
> 2.42.1
>
