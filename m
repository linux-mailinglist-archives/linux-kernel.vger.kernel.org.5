Return-Path: <linux-kernel+bounces-16505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26813823F75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855752872C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51620B2A;
	Thu,  4 Jan 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sparknarrowcasting.nl header.i=@sparknarrowcasting.nl header.b="SB8z0sGY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084620DC7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sparknarrowcasting.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sparknarrowcasting.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8ejhyNWJtIY9xB4JZnlRZ8gHQYcXnBMwwsbeTliGNq62SRAQQB2OY331yW8btKrYiLt8zJLV8ERPhqIOQn9MkMk7bMgFx8sIhKy5mvfiSzcx5kRtEU1p5dhmrrS6bSrXACLIEmnnU2y/QZEJv5AQatiBzF5p9YW5hJl8ZcZHvUdw/n5aUulZGsX1An/y3tb4rC5TGj3wsuQ08MDRy+Tkg6ibbvZzW494cPsrVDshRuChHOV7PE1a3tRsRohwJkJ7dJa9IqX2jhHnBygbOOsMsnVMqPmD8Y4veBWzvkzSou1O4KjvH61V80oki/LF2caBfAC/ESsJ3uiWsq6IjSH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTCHy6fhul/fEA2TdGkXPbflNER9ISDzdVm64/Dggfg=;
 b=GXiRweNKyy0O1YDwuYtTkBfI3YDuTi/BoEoiT7UWDaauhYzsP2NpPxT8Jx2FkdnORzLMqwkDqFgJ9AlGw8uwEy86jJ6icz+Tc1QBnzcPyHOzEZ28UUdPl16yGYP3mJTMnZdw4lr/cnxX1hFIZjcbkD4ugdKJmgYChT5QFAyNKygppgBBB34nhCK/+nIAGTb724FDO3ZkPQKOy9OzVEMjoT3PuNIGJ2poZRVkjxvHMf9H+mL+kC+p3PXaJaFUkysyPjAIGH+GbF2jnJlwcqHbj64boSiWEXCHDFxA6mvh2ZsPWozcZq/P6hPEdpLjhgrwxCpR4FjJ0EXk2fJWTHn9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparknarrowcasting.nl; dmarc=pass action=none
 header.from=sparknarrowcasting.nl; dkim=pass header.d=sparknarrowcasting.nl;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sparknarrowcasting.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTCHy6fhul/fEA2TdGkXPbflNER9ISDzdVm64/Dggfg=;
 b=SB8z0sGYijqjwt0wCKQHHX2oSKxhXiSUggDyheDRkvd0ozIXiS57TlNaXjQR4bLLnuQ7AHJ9Qx4GMsnTG1votDN7iskSe74CaoRq2YukPwha8SnV7WngTMJAp881E8384dP06VALLVox60is20BCRWmwl0anWJFEPbcnXaItOIOPcKCBkBwOGYM7gxy/g7XU/fbG4gSkWjwS1hVszxvvAqe7FbeLBEha4dFk0oeWWD/ZXcEa7GyfCXBOiGDc7tpkbI1Y50prs+k9ngJhWQz2NlPdTHnfnghc/1/73MLF8qMIEu4K+f1PTb7oMTjyXRolR+CXwOY/Xx8TXcMJopd+JA==
Received: from AS1PR05MB9393.eurprd05.prod.outlook.com (2603:10a6:20b:4d3::17)
 by AS8PR05MB8069.eurprd05.prod.outlook.com (2603:10a6:20b:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 10:31:14 +0000
Received: from AS1PR05MB9393.eurprd05.prod.outlook.com
 ([fe80::3017:1a1a:672a:8316]) by AS1PR05MB9393.eurprd05.prod.outlook.com
 ([fe80::3017:1a1a:672a:8316%6]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:31:14 +0000
From: Ben Mesman | Spark Narrowcasting <ben@sparknarrowcasting.nl>
To: "Fred Ai(WH)" <fred.ai@bayhubtech.com>, Sean Christopherson
	<seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
 Hunter <adrian.hunter@intel.com>, "Chevron Li (WH)"
	<chevron.li@bayhubtech.com>, "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
Subject: Re: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Topic: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Index: AQHaMnxhIfb+xohLkE2RJYfuBf5C87CyY5AAgAxHDQuACDsggIABNHyAgAFwpZg=
Date: Thu, 4 Jan 2024 10:31:13 +0000
Message-ID:
 <AS1PR05MB93931538EE9A569728EFA724B667A@AS1PR05MB9393.eurprd05.prod.outlook.com>
References:
 <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
 <ZYMator0DDfq_moN@google.com>
 <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <ZZRO4Y41UTNm88eg@google.com>
 <BL3PR16MB45703C79606C6A12CB4B24759960A@BL3PR16MB4570.namprd16.prod.outlook.com>
In-Reply-To:
 <BL3PR16MB45703C79606C6A12CB4B24759960A@BL3PR16MB4570.namprd16.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparknarrowcasting.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR05MB9393:EE_|AS8PR05MB8069:EE_
x-ms-office365-filtering-correlation-id: 732bf3eb-5258-4fba-0f43-08dc0d1046e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y8/BK/zbM1UYQJX/nky8zguF1XZ9Z7LhM30Y1zSOaxl3iPWLi1Wz3kY2vkxhYWiUUEm4uxZkADRuIu4P/AVk9hALQDcgmc86RNSh8QPfAz2bbEf1/PQgbH5QxFhe/vz3x/x2Ffh8ynAurPQ58zw3IYTcR29tpc+fJrBoJc5sLeSKfhh+ZQ8bAdFxniIVyFEOboLEP1nDiOi50vgdLF0cWX9SRe6H7f/OkbfB7A7u1N8WxT8mbaZqZjQpN+qFxOD241BZsUeV5AK3+4ji0B4OSxkS3k4JIi1kbiTh8xZ8InhPUkhG74OjYhmm/xJLrLKBrSIqdEFSW+MM8lDUj3tdsg6zB1o16FawtEreFYWtmBwmKBOyBN9bvVf+lhJPuMdWTNtTcqeNAi5u72JfqNi87cF8hRjICbrY5erMU/KnUWd/qQt/eVHPwZDutdJ4fu+HqU1dXsj026C6IEgGchdIOykcMI1s8ztJJFujOPHjG/bM4yooksqsko60fK2gVv6+ROZjHQKgPq/Vk5eFbqwAJhMYltU9ai3jAnvCzc30IZ9W/O9zJGx25DeMYjE8YoLi9JeVP+KL13xOZwat4zQtJrQY2VF7dnZuIidnS2XbP8zpDMyek3IMVSgyEykUk+Za
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR05MB9393.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39840400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(9686003)(38100700002)(71200400001)(478600001)(55016003)(41300700001)(54906003)(26005)(110136005)(66946007)(91956017)(33656002)(7696005)(6506007)(122000001)(76116006)(64756008)(66556008)(66446008)(66476007)(316002)(8676002)(8936002)(86362001)(52536014)(83380400001)(4326008)(38070700009)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?V4PtxfWC0vKWK0EhBuWNF8/FfGD0QPiTMcVP4R176AIbmQ0ju6PZ7JUU?=
 =?Windows-1252?Q?4pd47ysd5UeoyptgsIQ3/91txz1CtjVjNJPN+Vpt2/UdIS1Rxh+luZj2?=
 =?Windows-1252?Q?zRCcg9IxmWzOPCu3PWa6LWRZ14rb2F6NHbSEfZIlTIHjveVhoHhvfsYe?=
 =?Windows-1252?Q?2S9k1s3e3KNsJ+pJ2t6TyBqjqTKo+sobeAbMFnSgaTO27DEtsS4aPg1I?=
 =?Windows-1252?Q?mZ61MOa1uv1fzhMLrMYqWiyH3SlOueLNQAFtKdCeVjns9s9hQTr7rSXR?=
 =?Windows-1252?Q?vNKsDjbFXiSetI9IQrWS/K6T/uGHcKuys9XIcqKPyh2TZCaCT2yMDko6?=
 =?Windows-1252?Q?AqCxLkskZ4/tfAyjjWM6k2QlxMwdRh1WZ41irZY8PHC62LSy7XM9hyWq?=
 =?Windows-1252?Q?PADO7fs85KRwhL6ME5n1TDIu63bXcd4r+DxXfGHFSbTuNKYaXjXAWC3G?=
 =?Windows-1252?Q?wujON3QYjASNREAVhaMr4GgNf5tYq96yMiQXDwfnJkKiVDqgIhQW49zO?=
 =?Windows-1252?Q?Q8gZoGjnw2EF48ZuRVVwlD1/bP1vwwonEoKJF+mQAAST5+J7Zd0WQ/r/?=
 =?Windows-1252?Q?+2xMIuaXWjX9xc5Olzr6YKo5C8JbbfqUye0/iUty+yxxMWQmXuzEyr3J?=
 =?Windows-1252?Q?sIt4TDz3zbDP6G4iGufTNkYtwUhXzR5WmCZ5WHmbgb+dE5gkrxjXmD+6?=
 =?Windows-1252?Q?cqXPHFIOPPq8hRdN7XMX5BoD1bDBRmmmw4T6Pvs+1BVPhcRMs1XqmmSz?=
 =?Windows-1252?Q?y0bKxXI+xCtNYr8GmnEL/UyQ+jUKIS3wYPUSoDg5ZayKWz/Hjr8KX/ZJ?=
 =?Windows-1252?Q?NwMXruIXcCnMGjjWQ38Bwf15vv+3UESreyJHIiX9e5h2Jrre/BJmmRcM?=
 =?Windows-1252?Q?IErvEI7lP5Lm/DF9QQUnhKfXR+e1a8NxGB4BdjRg7hXp8ih4uHGCryM+?=
 =?Windows-1252?Q?aBI6cp1bjTNK+o/ndc6AfO+43TRz96U0VpmTNuUpgTwvyDcUOin+Ewuk?=
 =?Windows-1252?Q?gVTSKjN65C+idZzF5V6JH30rJlFzyzmgYV+HE8Y8wadD2K+I7ndRVaEW?=
 =?Windows-1252?Q?zpaD6gMrlMSy/Wn9SkyQmJ1S+3GjRESFJS1qCUPDxZz8a+5GIfSLSyzR?=
 =?Windows-1252?Q?X3T7kZZd9VrpqXEedtY+FZOcK+tZpDWff1DTk5V70MUdcMIIwwGc1qoN?=
 =?Windows-1252?Q?0uB3wmmaoZqiQ9GQKBTAv7Gu1zogQAraGRhHGJYIKqV/xwx40gfPNy1n?=
 =?Windows-1252?Q?wNhMnvuMCvNtQDTGRAQSHHUG2zIwA27ZD9mYQx7UNwIm9ZjdqG3Qdt/P?=
 =?Windows-1252?Q?ecRZ6qSgapHdEfLNhqQOCr3J+8mbuQmlaVVnNpdfmPrHQJbJAqHlZHCW?=
 =?Windows-1252?Q?UGc1UQwYkZbsLe4XTLfDslBPEWZdw51Ypvpjp2/T7VjotxCMA7oBkIC0?=
 =?Windows-1252?Q?Io9JB8X1S3N7OI4gXMHSpgCUf3Dzoa7kObhoyF9XIL6lVQMqS63s9NYE?=
 =?Windows-1252?Q?Wiu78gSgjxZ5TKiv8BKhMUC3tim3vHG+jGYR3WoL5JwmqvLpnLjTZOjo?=
 =?Windows-1252?Q?ca54GxvrCdtCHSZb4vc8mvontaoajmoIzKBehnVx0GbGZmZaXuau1gQW?=
 =?Windows-1252?Q?WVIePciQ/Wur0C7NCUy1jE37ROEKPZCXkJB3N6zVP31dIg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sparknarrowcasting.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR05MB9393.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732bf3eb-5258-4fba-0f43-08dc0d1046e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 10:31:13.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2366a43-d0d0-4083-9a1a-2c45fd57a18f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9yHAG9CMJb5UxVTRXrGucXoFCJdBit+VGoIlg6J8BpjXIRjATdFijB+gBsVAyaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8069

Hi Fred Ai,=0A=
=0A=
> Hi Sean Christopherson=0A=
> I am maintainer of module =93sdhci-pci-o2micro=94. I provide the attachme=
nt code to fix this issue, but I didn't test this path code. You can test a=
ttachment patch code and give the feedback to me.=0A=
> If this issue can be fixed by this patch, I will consider committing the =
new patch to fix this issue at linux master branch.=0A=
=0A=
I tried the patch, but it didn't solve the issue, sorry.=0A=
=0A=
Do you need any extra info? Any other help I can give to solve this problem=
?=0A=
=0A=
Thanks,=0A=
Ben Mesman.=0A=
=0A=
-- =0A=
> Diff patch in "linux/drivers/mmc/host/sdhci-pci-o2micro.c" as below:=0A=
> =0A=
> diff --git a/sdhci-pci-o2micro.c b/sdhci-pci-o2micro.c=0A=
> index 620f52a..d520369 100644=0A=
> --- a/sdhci-pci-o2micro.c=0A=
> +++ b/sdhci-pci-o2micro.c=0A=
> @@ -603,6 +603,31 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host=
 *host, unsigned int clock)=0A=
>  =A0=A0=A0=A0=A0=A0 sdhci_o2_enable_clk(host, clk);=0A=
> =A0}=0A=
> =0A=
> +static void sdhci_pci_o2_remove_slot(struct sdhci_pci_slot *slot, int de=
ad)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 u8 scratch_8 =3D 0;=0A=
> +=A0=A0=A0=A0=A0=A0 u32 reg_val =3D 0;=0A=
> +=A0=A0=A0=A0=A0=A0 struct sdhci_pci_chip *chip;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 chip =3D slot->chip;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* UnLock WP */=0A=
> +=A0=A0=A0=A0=A0=A0 pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scra=
tch_8);=0A=
> +=A0=A0=A0=A0=A0=A0 scratch_8 &=3D 0x7f;=0A=
> +=A0=A0=A0=A0=A0=A0 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scra=
tch_8);=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* Set pcr 0x354[16] to switch Clock Source back to O=
PE Clock */=0A=
> +=A0=A0=A0=A0=A0=A0 pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SO=
URCE_SWITCH, &reg_val);=0A=
> +=A0=A0=A0=A0=A0=A0 reg_val &=3D ~(O2_SD_SEL_DLL);=0A=
> +=A0=A0=A0=A0=A0=A0 pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_S=
OURCE_SWITCH, reg_val);=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* Lock WP */=0A=
> +=A0=A0=A0=A0=A0=A0 pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scra=
tch_8);=0A=
> +=A0=A0=A0=A0=A0=A0 scratch_8 |=3D 0x80;=0A=
> +=A0=A0=A0=A0=A0=A0 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scra=
tch_8);=0A=
> +=0A=
> +}=0A=
> +=0A=
> =A0static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0 struct sdhci_pci_chip *chip;=0A=
> @@ -924,4 +949,5 @@ const struct sdhci_pci_fixes sdhci_o2 =3D {=0A=
> =A0#endif=0A=
> =A0=A0=A0=A0=A0=A0=A0 .ops =3D &sdhci_pci_o2_ops,=0A=
> =A0=A0=A0=A0=A0=A0=A0 .priv_size =3D sizeof(struct o2_host),=0A=
> +=A0=A0=A0=A0=A0=A0 .remove_slot=3D sdhci_pci_o2_remove_slot,=0A=
> =A0};=0A=
> =0A=
> =0A=
> Thanks=0A=
> Fred=0A=

