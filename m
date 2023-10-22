Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC67D275A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 01:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjJVXsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVXr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 19:47:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5088F;
        Sun, 22 Oct 2023 16:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU24wtk2y08500PmbqEVI8wjAOGEU22PCVTNtkb7Tk1S42wCR3Vqb9N4s+Zypu8b1W6XiklMaRNZTNFZDklVxFY9mHJwGnLzcQP8zDTxbWRJVnocpBpeu85j/hQqyE4CkhO8CCDJBhdXwU2MUTDCn3a77Wc7UaDda+bKsKgqF88QiLZdQnv9AtKwnvAUivcnnlt2ok9oC4VPlHexCryp6vc26RWpyQ5PRCMdZmvGcyUP5wJtBmzoHEAFuNUed0B2IJIiTYItfk3naPb8OOTdPZRqiBc80dSSCn0grIaHBM5FzSlVVtuVtdFXZNTbhPoKisSwOoRGgDuqApzb7lCVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbpHNLs5Z2//oI49RE5WN6TlAYXl4uoRUUOfdqjP5Qg=;
 b=VZLmOYJIOicRmJY1XzmLRbJimd3F/Bprohyv96Lt8qxe/lAhPVxRT78H6zyDuByLJmRdV4ZIzpLofVS3zj1OV4pe07o3YJO5fIVf2+4tFIu76VffDjuYw4thHFG1pB01LYNO3fiSfaA2d2VxfbLqUbj0N2UcEotbKbzQ+7n+t1Dn3KpOHImCtuqJGWSQcr+K3OKxqry6oUeLx2IQz1bWZszYIIU4+y0h+LLedl92tQhYoTy616d/xjSYESv3zA4/KF31mZctpXVWUCT/iO0IDHGIRCN/csUCnE2ZqWNO3izrIHufOcUxilV+pnVLpruFVVc7Na0jYZwym9K0qgd9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbpHNLs5Z2//oI49RE5WN6TlAYXl4uoRUUOfdqjP5Qg=;
 b=Q2yMGTOVdxBdDCWv2j5IsHR5kRvbL7D9QH2tZZ26DC4Y+oovPUF/ElBpE9OYAZ2p7Oks6Tqxx0I04OXAGEws8TKB9fe+52doSvgBn7AE3SSdiH5GUCgRFgSQCFzoO06GfTYkv1QSNCxvrbnevFCZDe4kbgXmcvZw15nVs7Nj3dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV8PR08MB9286.namprd08.prod.outlook.com
 (2603:10b6:408:20a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sun, 22 Oct
 2023 23:47:55 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Sun, 22 Oct 2023
 23:47:54 +0000
Date:   Sun, 22 Oct 2023 18:47:51 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <ZTW0p2WG3/m1Tx+Z@nixie71>
References: <20231017034356.1436677-1-anshulusr@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017034356.1436677-1-anshulusr@gmail.com>
X-ClientProxiedBy: DM6PR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:5:337::23) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV8PR08MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 34487936-e89c-4ef7-92be-08dbd3594fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27QNG4G75H+eACgIymCqYwCxl+h/CnU21h0CcKobyM4+iQgezDYK/TBQYluEh7QFPOOuN3vMmwW6u682NiQSSGAHWhqGgTZoScowfbmZohdK5r16KDXUlebG83Bjv+wFkiNf7im7qpnGWo2RfbJhzdss6lhU7GM4Zc4Z9L2wN2/Fm1egdoU58HSSWZ7zesFu0L8T8ZhgqmqRe2pKHVpTpjNBIwgkhe6tt7J2DYUmP3MR1bD80LSAsTGV1OfYYUDCxAtx34SxLsEqoXCWYLYwryD6a/qY325dY2d4oMfKuchA9kSl7JB5KVJxoKzulmqtG9qcWKb3TSgEzg+MlkiKGaxVAgoAqyb6CRPLT7BR7UTiAD24V8y3a6z8adkTbNkublwewlHF5gkmrkVIO2mKt+o9RFku5F9sBLnQVAKNyjnlSxN3+qVn/ID6EoEJccbn2BPlNqWAN0CKUmatjk7LCaX0A0tUryW5Kdz3a7T4Eug6d83CuRT+joP+/1oO/IMOgYV4i5k73mYoW9XqtG/dL/dzmLqsoZlWAI3yD+CWAOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39830400003)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33716001)(38100700002)(2906002)(41300700001)(86362001)(7416002)(5660300002)(8676002)(8936002)(4326008)(6506007)(6666004)(478600001)(26005)(66476007)(316002)(6916009)(54906003)(66556008)(66946007)(83380400001)(966005)(6486002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ntw+NENxfilzNNI6SE3DIPf9ywrjESvBtArqKi7JSghUkvTcxr7dkN4oPlvC?=
 =?us-ascii?Q?ygyvNhJNDh32KLWN9ljML3D7zoz44ZXCIUr0G4PtGxto3NhzbDwPZDxP4IhQ?=
 =?us-ascii?Q?VXUPX3y3nZgBDgBYWhcNwC16GvXLJhQXP1e+gBDpfCComwtLoLGmSaoDQReY?=
 =?us-ascii?Q?IQh3Pdj0OBF8p7p4Kl/LqKdtcUqqUrb+gN6H1wXzJNshvZrLIlOJvlPKXEEj?=
 =?us-ascii?Q?JK112YTknTaZMd0awgcFz3Lt6DeLQsvuSS/3ZzM0G+l9dtm4oNUl9trmqfsY?=
 =?us-ascii?Q?mbCkrq0zgY3VCmzgSVZmijd6xlUua1EjbXKPG0Pw4Q1XBOABLlJcJ6f61xaF?=
 =?us-ascii?Q?9P3Tca0S/oEk6Q0C3Sc20+EznCvEyBM4Necn5phL/8jUgwcefdsQTb282f/6?=
 =?us-ascii?Q?urKz1eCVFd14zSdvibANQLt6jniBge3bNtSDOORypzUecL9/bXz4aVG3hNbN?=
 =?us-ascii?Q?TkFjlmFTtt2gDfWjO5J2ox33qYEzCiETHm0dDMIYIhYanCgG9rBbvhMtuVT+?=
 =?us-ascii?Q?B3joVlHw171eiga9wqr6HyKiUTqi+pswiYxS6NN3KatnM907T+54fOqI8UM0?=
 =?us-ascii?Q?3SFjbGklfIzkcKU/uNel7MsuS2jgwpgrlfvPNuEVMWjufs3DaUCB3csOD3MR?=
 =?us-ascii?Q?ESnRF7R9xkg8z4ctcDCNmwu35IDpxhOc+597BZidQ6QeZ9SKZ3tlNYo/K8Qu?=
 =?us-ascii?Q?n/CPwDdOSsKC3oG4ZyBtTJMP5NeUEniILCaeuBzDS5MqV4VjgPCyXdRz6ENL?=
 =?us-ascii?Q?LTKVu+i3crAhAJdAEuwRc7pgF2BpH+62QCBl38t+RNtjeEJX2fFWB5D7/PSu?=
 =?us-ascii?Q?7M601SCHDrmiJJuxUQkAYPzXPBR1v8ZAvrLT8ZYBE0vDx2aJouAAZgCKluJ4?=
 =?us-ascii?Q?qw6mCcUsgXEXY+3HtCv9ShY2SnUPT99DTIYxA7D4Lhg19ArbYbgddGG3N0to?=
 =?us-ascii?Q?tWemTxNtmsI7zJkm4q3Go8KC1TxoBBPFMEs8VcoUdsIBeOW+URZROL7kpyBC?=
 =?us-ascii?Q?YAkSPgDN3bRIhl4+MZrg+ACzcYWtScyBCVJXPgTFUfu0uzOmorsgufyfCz6Y?=
 =?us-ascii?Q?/JVEN6BJLXAYHgNJaokTehWFsj3h7MKKI6Xycqjj4xsRp7soDGtkRzs2i7FV?=
 =?us-ascii?Q?mmYfs4hR/Q2vb+K+iyDxBtXXi3s9J+4GKuRt9jpQ3+PJ/0JidRzPjjhCNSBm?=
 =?us-ascii?Q?zSTPiVqSo6mmYbot/3n4YHmDp543Xdis/h+68VBpHV+ZfZ0acaOD5W0QiKkj?=
 =?us-ascii?Q?/PkQ/2ElQaq/BTAWAjM/rAt/S3dsSgNgCwbAJNCLxENd+RVAA0tDshPZBtF+?=
 =?us-ascii?Q?V5+cIvI0Cm+lhE5z8TRlz6SeB9DX7uXUWHFVcbqRyL0RPfc0k3ESWbOPIvZF?=
 =?us-ascii?Q?lTKXyYe7QCHW+7mKr0JuVMeQx2Mr7TBJ5akFmVqlgixESksrgaayuV5cVimI?=
 =?us-ascii?Q?QCHmEl4JCX8gx0gs5oPtaVO+3VwblBGjucMb9pxNucvnc43irjNgjCY+I2zH?=
 =?us-ascii?Q?tTy6+Hk3ShZnE2r7afwrRPk7HgD0q6FvzjmgZo98aSW7AaaZtKcoVG7I0D/l?=
 =?us-ascii?Q?dxL1sbZfOEERT5M5gi75dcXFuRvkvdYvKo97a6nI?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34487936-e89c-4ef7-92be-08dbd3594fcb
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 23:47:54.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs6hUmugV4lgZC1Ff0NBguRDcnfoJ1uoJu4yb0ryB8e6ftgC6zVUI/pQUuqM/C9pDs7PP5Ij/Ljf88hqoKwMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9286
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

On Tue, Oct 17, 2023 at 09:13:44AM +0530, Anshul Dalal wrote:
> Adds bindings for the Adafruit Seesaw Gamepad.
> 
> The gamepad functions as an i2c device with the default address of 0x50
> and has an IRQ pin that can be enabled in the driver to allow for a rising
> edge trigger on each button press or joystick movement.
> 
> Product page:
>   https://www.adafruit.com/product/5743
> Arduino driver:
>   https://github.com/adafruit/Adafruit_Seesaw
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

Perhaps this ship has sailed, but is there any reason this simple device
cannot be added to Documentation/devicetree/bindings/trivial-devices.yaml
as opposed to having its own binding?

It has no vendor-specific properties, and the only properties are the
standard properties already understood by the I2C core. In case I have
misunderstood, please let me know.

> ---
> 
> Changes for v5:
> - Added link to the datasheet
> 
> Changes for v4:
> - Fixed the URI for the id field
> - Added `interrupts` property
> 
> Changes for v3:
> - Updated id field to reflect updated file name from previous version
> - Added `reg` property
> 
> Changes for v2:
> - Renamed file to `adafruit,seesaw-gamepad.yaml`
> - Removed quotes for `$id` and `$schema`
> - Removed "Bindings for" from the description
> - Changed node name to the generic name "joystick"
> - Changed compatible to 'adafruit,seesaw-gamepad' instead of
>   'adafruit,seesaw_gamepad'
> 
>  .../input/adafruit,seesaw-gamepad.yaml        | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> new file mode 100644
> index 000000000000..3f0d1c5a3b9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Adafruit Mini I2C Gamepad with seesaw
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +description: |
> +  Adafruit Mini I2C Gamepad
> +
> +    +-----------------------------+
> +    |   ___                       |
> +    |  /   \               (X)    |
> +    | |  S  |  __   __  (Y)   (A) |
> +    |  \___/  |ST| |SE|    (B)    |
> +    |                             |
> +    +-----------------------------+
> +
> +  S -> 10-bit percision bidirectional analog joystick
> +  ST -> Start
> +  SE -> Select
> +  X, A, B, Y -> Digital action buttons
> +
> +  Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
> +  Product page: https://www.adafruit.com/product/5743
> +  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
> +
> +properties:
> +  compatible:
> +    const: adafruit,seesaw-gamepad
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        joystick@50 {
> +            compatible = "adafruit,seesaw-gamepad";
> +            reg = <0x50>;
> +        };
> +    };
> -- 
> 2.42.0
> 

Kind regards,
Jeff LaBundy
