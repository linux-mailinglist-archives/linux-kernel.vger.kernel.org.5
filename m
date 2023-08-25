Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4963788E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjHYSKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHYSKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE891BF1;
        Fri, 25 Aug 2023 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692987013; x=1724523013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w7rb9HWxItHZNuB+BnLcieDjD+lqRzcsNBp0+kzedpA=;
  b=HMLnqT3go2pdpQiaX/9ibsRtWYBao6uUkMN++btxf2V8bkrXSVQWNYoF
   sfO01735gDoG4kQh8AmEq40FgEGiDEemFJ6xGqqJx3c44svVHCMyf1UE6
   d/KgQGoH8jDWPPJ8606bRDgnzwXNnmM/l4x2MydVMbUg5NPM1O2ODgT0M
   QsA22b8210/0pFhc0KOQ+y7z0FL8DJaO048iQlsBGFXRFwu6rQLiL/1Ri
   82DBSKB9emu2CZV4eDzHTOqdpsWRbVcn5fnya6EXZu756KpHtSuWPeB4K
   7SExxccMMeafvtioojwtLi77KVx7Jg7Ayyy3+Bw/S720ic0rm2n8syIH9
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="1301320"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 11:10:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 11:10:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 25 Aug 2023 11:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1SciDA2X2RmakZ8cSm1Qzc1ksJkkFI16iB7u1o765WJfgHaB3GsqIuX2xv9CK1BajpSTUukXDs9SxMwKsZPsd7PcWxTPqnhnj7eHI5mWmKUbJPp6RXfl+dvZkztlFfjD5OKFqN2FoBnB81QSAcGhR1sE8VUohDlj3klZsWW382eQBGeIpUX4sS/aNK8BoLkeHJq65W5h2VJlnOx9RcZiSaerILrYGzkvpZgKP/y/hvrVcIJx30YZTlJfyIljWLGJ7F+G6MeCSYMZNd0Tb8h9+8IjoNESxBRs1nkB+zpQdKVtTFL/PNTq8f4rcVSPcjZ8sNVGNx24apAUM2IFAu1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF9Fp5tOaQW30f6KU7nyLdJGfuxElNLFOmXUEMRNG1w=;
 b=g06JXh66GcWttSR8RHYzg/h5FAIepS6anr6gIaXrm+BWrDegx5XeF8NH7ou9ObePfU+H/njLFtQGmagCyhWroN0Wk7WNfm0boTpj9dyVgsBgnmgHTk8y7kz7yKnD6oZ3pZcdD932kyX0whzZTM25d9sHIOoEAaYf+3P/uVzqkJeuXhFl/A7CIviyFcgcuOd1TPA5eokJxB90wruQcw0GutIz7E3AqBFkN0woZqVTa9IjPfy+DTo8+b4YEcpQuN1gNYpago2W6DlPljP8WaX9z/hM/Uex/uagDnnAMpA+n0L8vBB+WskjHBjxriLpmLSmKl+ouDXTRyXBRRgVwQImZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF9Fp5tOaQW30f6KU7nyLdJGfuxElNLFOmXUEMRNG1w=;
 b=memobKpDRKSzsqa0snS9tzKkPxR5HUdNSeQ0rhfaDOQiDHIkjqggz0ytY2fqXMlw4QGiclN/DcfLghhK6TyNU9NW/44Rx+rEcnkgIXkT27DVTIHLTPGnOwjnUiB6F/H9PyYFdDH95nfKpVbGiHXn1rlNJNiHDyZzXSXPcmbGR7E=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 18:10:10 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 18:10:10 +0000
From:   <Tristram.Ha@microchip.com>
To:     <lukma@denx.de>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <bigeasy@linutronix.de>,
        <pabeni@redhat.com>, <koverskeid@gmail.com>,
        <matthieu.baerts@tessares.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>
Subject: RE: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Thread-Topic: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Thread-Index: AQHZ12lYMJ9uNrgi1k6Tm7c6yM2Sua/7TeQQ
Date:   Fri, 25 Aug 2023 18:10:09 +0000
Message-ID: <BYAPR11MB355805618F510948EAE18278ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230825153111.228768-1-lukma@denx.de>
In-Reply-To: <20230825153111.228768-1-lukma@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SJ2PR11MB8421:EE_
x-ms-office365-filtering-correlation-id: 17ee19c4-e2ad-4594-639e-08dba5968517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUaZnWRN60L2cFrUnXTCBnjonLdXvQifqJDA1UPnqyPgNXkGu92H9/2c3TcLyj0iLAlKWxW2TEKNY5j6aJdHDZPF0a7xzUmYe6wRN87SN0ThZHMvrq4KCQuejLeJnknpl16gu2eu9dos7hTMUppWCWdGMFntDC0jtgGCCqxLs/Y/0d3K/LH1Qp9kwr1GZ0ApH23/EQzaKkNXRAgPLANRpqBZhCF2+i9ILu4ZRrpfuT133Kb2mwY8zLbeMZCtUt83k9zskjim6W27BqnfcpNvgOE/PO3jyDO62smdrjn6R2QjfXU1/lpAbxACIDHIq36iIkUCNbdVaq22yUohVviEHnoK2tr7oWYEE0hiZtMpKd7s1ru//Ojs/SuXuLHEwYadttEUscofv46k2iP2panVXgVmIAtG5UB5GtW/dSy5DamnWghniu6uUdV+LIgIRKPvMqTfl9wiyLMCYl9UroZforB3Ctl9eyUoHkxHhxZ7DOGbqfc2eeCELsVXs+RuMX6u2fBytPaEXFe3HGel7xVDHa/9PDYMmhCzgOesbSCVlwuhqIs9oyFT4r+JpUHRjhmNgInTIOSMcT3pGEhk2o+uEGqN2jxwg7pWIShnLeXd35iSsktW6iGUCZuz+QMF4NK7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(6506007)(26005)(9686003)(41300700001)(66446008)(66556008)(66476007)(7416002)(6916009)(76116006)(316002)(2906002)(5660300002)(52536014)(8676002)(478600001)(66946007)(8936002)(4326008)(7696005)(54906003)(55016003)(71200400001)(64756008)(86362001)(38070700005)(33656002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?45vCNxn9KorEAXmc0U21Umvyo9SZrLCBdjSxFZ9eQaLDU8vI9uWt0A1f3uX3?=
 =?us-ascii?Q?YwUSFqGdWSA91hKV9Ki98Io+zQtszsds9UIHf348PHx5lxolIYKAZoHwZXsV?=
 =?us-ascii?Q?7FYf6KUgJ+Ef+jl/gGH0oslZix/M/DCqY9wfQkM67NvyG2WMrFeJ/dwRF3/L?=
 =?us-ascii?Q?XWfBkY3up++2nv2YC0yNz8ZNc3bN7X3BKyl0KwtQ1xFQfQiOKXMAsSfmByW7?=
 =?us-ascii?Q?WSMMSu7Aa+pfo+8Y+IHJxcF/LpcatlDwp7u+Y0c0R3XAjJ8w45Re1RbhtpU5?=
 =?us-ascii?Q?9pERjRnVu6WZj3K5ry2h8iUWK0eDolsUnEUu+amct2HlZ26cgXhSuDJqoJ1b?=
 =?us-ascii?Q?xLBZHopOXoEgalcvDdQ5Q7ejZKmTNadDGfxz16z3cyrdBiSHOD15Eb/i4RuI?=
 =?us-ascii?Q?yNqRWFnuiM5damKgi9xlHtJne7/T96zLQQNKsywCdQSvT7htM9WqlxXyC+s8?=
 =?us-ascii?Q?xalB4ES3jl4FoOJE3F94cZcPR06Z6kuJ/wqSFzeBvvwxqPlom4bnGCkp1s7B?=
 =?us-ascii?Q?iDgQfja0PJt65lTXiddiIC/ZiegwO7DD2Zqi845eGjfb0RzEIF54DdZfvLgm?=
 =?us-ascii?Q?VOjQfVL+wNSL+WIjrjT7G8ghC6GF0m1ePsCoR1F4IJsHuI2m1B90I8+3rT37?=
 =?us-ascii?Q?Pbzqs7UuboFj+9sD7jcTG1VtKBfPCSznWU+giRzK+CvYRO2xsQ+QqG0ZHEjr?=
 =?us-ascii?Q?AXIxEZIA2fwv1ed7met6AzPkMDf3ecz2wK8NsPoNbfAFTrVaJ0NSULaqKvQy?=
 =?us-ascii?Q?YM5eCZpU+vAaOHtK/FUYZbVB5SHKMoZtbQ3aERb7MjfNPVLzZIdUAZ7aAcHV?=
 =?us-ascii?Q?JLeukcmY4yx2q8klGJyIshysVq7lIwH70stTmQ3rn+HummeqddVIM3FaOxj2?=
 =?us-ascii?Q?WIKQ4Yr6eSD+992pe90a6vwUdkVnKRot408RD+yoPuDn5dmLorr4NVXb0206?=
 =?us-ascii?Q?bxLdKXXoWdF4LPH0vO8713r7/Bju5oalwo0Wv3685Ua5IpxQ6DaU+Dipgu8N?=
 =?us-ascii?Q?vv5qKbs52T+Rj6HFvtFV6WvexxhMRhx7ncwnQ0/YYgI9oLGhR686h+Ero0Nd?=
 =?us-ascii?Q?UK+cq8JMQA+khHZKk0jdug4c+FYvHLblgCioqWhcDElUtbrjWltzjpzke31K?=
 =?us-ascii?Q?Q675ruXQG2LYwtN/5oEGKoVb5EadkmN6I/YTtC88/eJQYyNkmWCfoHj1zAPj?=
 =?us-ascii?Q?/XZ315z+6XaEg32swxCLflRxKuuSKzqnEXLDBFht2VJ5Mk2PpeHZByvbTlQy?=
 =?us-ascii?Q?gI3dHtsvDpxfc0m752oIivWM/Yaf/iyO/DT/2mvF4e6RuNKVV4/ExXo04iPK?=
 =?us-ascii?Q?To1UdlADCqGNyphTkSkwes5JbscngBTIf/PIYNDuF+CfGM04rzHf1qCEEWif?=
 =?us-ascii?Q?E8vE9DKq4xPtEe1QDK+t7g0IgBTajNqT9MCqfXW+d513zfYNbqgFtQ4IEtnx?=
 =?us-ascii?Q?gfDqjfTNupTYAuuBZi6itFt5Bw0NQpk2QOxWrrSWntu1NCjrbq0cnUIJLOIB?=
 =?us-ascii?Q?Vxmb8J7U3ELEM0uc07+daOydIeOzKmOT/qDCYXvQGBf+tYFwAfy9pm2sUjrR?=
 =?us-ascii?Q?xw75QZG4Ha0i4d/d7HR1n+8b6D0dWjfyUOsvcFwF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ee19c4-e2ad-4594-639e-08dba5968517
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 18:10:09.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byGTPAcwDlCVep1l/k8pgYnp2A+P0tmOMLJsWUPpnalzNMMY4EpiWTVYWToDYTibs1VilUCIPLoIXJltrRygnbbUFmXoMJmui0tyNm1n9LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -       /* And leave the HSR tag. */
> +        * And leave the HSR tag.
> +        *
> +        * The HSRv1 supervisory frame encapsulates the v0 frame
> +        * with EtherType of 0x88FB
> +        */
>         if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
> -               pull_size =3D sizeof(struct ethhdr);
> +               if (hsr->prot_version =3D=3D HSR_V1)
> +                       /* In the above step the DA, SA and EtherType
> +                        * (0x892F - HSRv1) bytes has been removed.
> +                        *
> +                        * As the HSRv1 has the HSR header added, one nee=
d
> +                        * to remove path_and_LSDU_size and sequence_nr f=
ields.
> +                        *
> +                        */
> +                       pull_size =3D 4;
> +               else
> +                       pull_size =3D sizeof(struct hsr_tag);
> +
>                 skb_pull(skb, pull_size);
>                 total_pull_size +=3D pull_size;
>         }
> @@ -313,6 +328,19 @@ void hsr_handle_sup_frame(struct hsr_frame_info *fra=
me)
>         total_pull_size +=3D pull_size;
>=20
>         /* get HSR sup payload */
> +       if (hsr->prot_version =3D=3D HSR_V1) {
> +               /* In the HSRv1 supervisor frame, when
> +                * one with EtherType =3D 0x88FB is extracted, the Node A
> +                * MAC address is preceded with type and length elements =
of TLV
> +                * data field.
> +                *
> +                * It needs to be removed to get the remote peer MAC addr=
ess.
> +                */
> +               pull_size =3D sizeof(struct hsr_sup_tlv);
> +               skb_pull(skb, pull_size);
> +               total_pull_size +=3D pull_size;
> +       }
> +
>         hsr_sp =3D (struct hsr_sup_payload *)skb->data;

I thought the fix is simply this:

	if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
-		pull_size =3D sizeof(struct ethhdr);
+		pull_size =3D sizeof(struct hsr_tag);
		skb_pull(skb, pull_size);
		total_pull_size +=3D pull_size;
	}

-	pull_size =3D sizeof(struct hsr_tag);
+	pull_size =3D sizeof(struct hsr_sup_tag);

Note the sizes of hsr_tag and hsr_sup_tag are the same: 6 bytes.
The code in 5.15 before this refactored code uses those structures.
When using v0 the EtherType uses the PRP tag instead of the HSR tag so
the HSR related code is not executed.

