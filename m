Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC67B5B39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbjJBTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJBTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:23:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD03AC;
        Mon,  2 Oct 2023 12:23:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392GjUJ0012172;
        Mon, 2 Oct 2023 19:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=BEnZoWkasqA0x5gN2Q7lfEL26g2qBw/vTs45S4kyDUk=;
 b=JrKY3CM+JLQyvxRZjHp84R9cbuiVcbDvshAD7UxuV4Zvj77VUsAjQZYUH+uqa0us0Cj1
 2iU8Lld0F0azZmbYuIwJ2v+6d14/qkIflNZtS1CsLJo3eUOSy4eMyizGMsQR3Nhx+kOC
 fdGT49hzZxMkb2ISZ1Pix7t7s7u6GSNDKWFdktcCxI7Equ06Aqwx72vPDK134FNphpfW
 fplJkI0LzffyKvyIAbyrqVbHSkqpE3tKa+A7aoXIYpak88QSX/V3TzSYFt72kmitRix7
 1KgI5PD7Gd3a3xeTfbHl8BCQCd7icKBcjcZc6PTl9v4cM0bdnfBnmm8p3kZDnx+VhWXG QQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3teamxmn4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 19:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlkuz8VwL5ONSpTEGI9/48vxO+4GGW82QZibEujq+8BeaCGref5gCiGYc1DzSZoen6ZGiOANFtnyWI3cCCxG2YtaLHcurLvy4AzhWEOauZjoXQ0A/9iJtgicA5QQr7gTLS2vGhcMA1rHD6vowi/mIbTSqaqGdGSeSmCnHOukQzzs4nHJhhnyD+PLIoWIoO8r0nzoww7eMsEPevPmZefo9kta7hxOvxWeoG+WTkZnFTHIgvIuQvOOZrswao7D+C1YXWpyzoFhR0J+Ije6j2+TIi12r8xEodV2bCLlvY5u2fCJPRmaYlB3AEetxStPGf8eNR+wCzkH6lrIZMlSaY9NeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEnZoWkasqA0x5gN2Q7lfEL26g2qBw/vTs45S4kyDUk=;
 b=jx13VIlLARqj9jIBRtYPPh4A+wOMKgCRgk2KVnQz9DWrNQOXQGo4EqZVpYtmp27O3ZYLeo7JlbVDHhhj/ZngGHEnyzvDYxQUbFqvhhUb0v/ONvBy+gdV8DiermJBbOgYp2K9giurcvDATtsZix6ZEJZnvOhEsvisJlOmrW7vgvJc8LrDANpuK52Vn0Lur/s8bZ0TOoNyXt0KR6inqO4jpSI3pmGPIufcMp0h5moC9/mcGKgMe5ofVkD3DXWAvgrRnf8B9BtYlhUHYfKk/N3dR7+v1mmbI2dHGgLteQ+5pYE00goD2yPLsfTntRrlL2C3xElDOWVqS6h3RalS7sLeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8073.namprd02.prod.outlook.com (2603:10b6:610:106::20)
 by LV3PR02MB10029.namprd02.prod.outlook.com (2603:10b6:408:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 19:22:58 +0000
Received: from CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::47bf:9c43:4be5:fb47]) by CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::47bf:9c43:4be5:fb47%4]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 19:22:57 +0000
From:   "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
To:     'Will Deacon' <will@kernel.org>,
        "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Topic: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Index: AQHZ6lSZigcTVLSCpESPLC2zOarwurAx9/eAgAT3tZQ=
Date:   Mon, 2 Oct 2023 19:22:57 +0000
Message-ID: <CH0PR02MB8073FBB64A196EEEFED11BB7F6C5A@CH0PR02MB8073.namprd02.prod.outlook.com>
References: <20230918172140.2825357-1-quic_poza@quicinc.com>
 <20230929150459.GA30623@willie-the-truck>
In-Reply-To: <20230929150459.GA30623@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8073:EE_|LV3PR02MB10029:EE_
x-ms-office365-filtering-correlation-id: ed8a16a5-580c-4958-093c-08dbc37cfc4e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQ7nu5+DKxPf0LgH7KgfE+sa3zzd11DHDrQyfFH3EJZd3HhnriUOPWPEbw44jn0zEUkkxJySi7c7afi6IcyqU+rwm3my+4t+wyKJl6ifCvj1pE/RoT8JoydXeo5SD9Iu0EvMQOluVUTR59izjCn8rlFZQmyINlE4xTifqG9RNtWZ0Czbi5vYXMTUo9gjjQtJp3kIBDoOl4LSyjcJQvO2zSzm0N/rG2RTTQZsgVCUJNkB3Lgs9wvzD80tjYk3SOti9MXZMREGkjOGSqztlbJWJWFSHRL6F4t6QyX6CeoppWqQGtS4URU8xLRWmavh9aCXIC1zPv3lEMVyeYwmdByacQtiAnBsZhlvw5Tgvm2GRqLE5Gr29p07AlaZ0z7SuGlS2+488JJ1MX5j4Fy2Ko0iOiIv0rv2kbtso6+qJu7pSWytCVjlOR1qShyainmnNBJIPjNfAaAvAUjwTTL+QY6EkvwsO4tqibJOX6+dVrDCBazKN3Svx6c7xAAzC96LMiASCE4bpRpEIPKdOvwJe1XhlaWO5c0Lp/+p+ib49CXNf9Mt3NLj6OcYWP8on+ndxdvzjHiiIXPNFRBo7VpQ/dF7rXNY8UTw5QWnFaptEMK6a4c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8073.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6506007)(7696005)(71200400001)(966005)(53546011)(478600001)(83380400001)(9686003)(26005)(2906002)(41300700001)(76116006)(4326008)(110136005)(66556008)(5660300002)(54906003)(316002)(64756008)(8936002)(66446008)(66476007)(8676002)(52536014)(66946007)(33656002)(86362001)(38100700002)(122000001)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7gXgKv8bu4awCkBTJID/xQhnbTJWX0aRKGmphpu9b/WNiS+L2m6EIU6xkC/j?=
 =?us-ascii?Q?uVwerw0VzEYnoPPU1AaxPu3tPWAwUHfD7VQ9juAsVr9/4R0zKw+3bkZHpg7B?=
 =?us-ascii?Q?Bkx8QWF1fregIf5eGPo6t4o3N07F7/QhJUHDkR3YmD7Yp0mAYOAfkd9eNAz6?=
 =?us-ascii?Q?WgRc0EDJp71Njq+9JjXhm+wGENOKsfD0QO/eng1nlgEYT6s64P6LQU/eIHkK?=
 =?us-ascii?Q?+JbazumpIiPs01SYH8wBoZ40Yn6DLucVLg6HvmF/f07A4C+icieB3w8g7cce?=
 =?us-ascii?Q?cAVOMhTkt7PI1QhRJ4bBvmLZXsknZhudkLRtQeMl2Ot+MR1HbYCf4vs8U3Ma?=
 =?us-ascii?Q?o3k/af3B166Dn1Sji3OB7STirX/BDb4NnPUpb5JEMjf9mx0s0BmgBSQSs1HC?=
 =?us-ascii?Q?dmuDNlvBVCRb2nkiaw/Amfzgy9+DrJF1dVN8jsGJJmKACzcYAFAbIC6v5fL4?=
 =?us-ascii?Q?u2DVyuDO8V58s5315Nc+kwVUvXZHBjAqtIPY3ZrrZYkFdBdDKXsE27/mRLkX?=
 =?us-ascii?Q?RfdCUwsnLvadRhOK3VOsyTAsMwd4v7fzVKu2SFoxTxkaG6szl3HudwQcqaQ/?=
 =?us-ascii?Q?LtYnSfELM2EdnIBe8y+XS57CKTUTb8Fs5+qgIM03q5BD7YYRmyLbSrk+GZnV?=
 =?us-ascii?Q?lNukWRY0KIRXSNvxSPhL4Aq0GKoGy8YGQYCqBVQapqgXgJzXxMuxB0scvxvt?=
 =?us-ascii?Q?HJ/JDVucTL6MFEP1u3diTY0aY+L7bEDZMCKWYJXlznqmehSzrSichiIRloMf?=
 =?us-ascii?Q?UyIRg14hN+fmAddn7tzw8mSl/JkvNz0nPoTbZI1qRf1aw+RqMp2lBoLqrJPS?=
 =?us-ascii?Q?KINC1qTtqg8cRyoOoDNfOrPol+OiiBUGOP/51dBGPR+k0GUdnXC/pPS0y3vS?=
 =?us-ascii?Q?Fypaph1MPne3BBbfqZW6ujbDyCfkGJ3RGVEJQBeIONO7Pu0MJ9uLm8xAVef5?=
 =?us-ascii?Q?viH8dRLAzVDwE/mn7WljFqAHBoI90PL1B3gcpnM/dYTDsVg45K4kHiu1E9rR?=
 =?us-ascii?Q?KqkFGa1RbUtl5UICzyh1B2SoxK1ZxKRSIzuxjegSpTxlTKzpSr3YfeVD46Kq?=
 =?us-ascii?Q?srtRco+nNRUTCKbL6gz5+oNPlCtGvIfDQLbxJCaB+MFEvnWhV5PEJJ1yqLdr?=
 =?us-ascii?Q?AuTtD7LHCbPJiF+LIdzM56xAw4jDII0TgYGYXKOO8MZnW5KRsSLfN1TDrmrU?=
 =?us-ascii?Q?e+LXnDiQTrIurpZXAHs26hlMhmCXvE9L4wAwgeXjYHPUi0EkB2ZV+DA+lIHs?=
 =?us-ascii?Q?5sRpceY2w3EiYwCG+1YwBNWBmlmtjQmI2LDoBs46PKdXHTBjteHUAj1zPpSh?=
 =?us-ascii?Q?DajYwecGUqALQY3B8WOdt1Wj4O64B/ohlwOx8hoefLwdePvKtD/oBzAQhuJ5?=
 =?us-ascii?Q?ySfiS04Goyq7pgf3HwQyXUhmjzUELSvouku0rEQpO5e+OjF9qj+pTNOZAZX2?=
 =?us-ascii?Q?3iM474IPFsZoS8bCIkXQFjpU61sJEO5JXEaL0gsoaUf7ACifYoC96P4OAeFZ?=
 =?us-ascii?Q?4GiXRSYf1Bv84xdpksIov3XgBpiiXS1ykXyNr8xmtFwPhE9qX2/HoSQM+0SF?=
 =?us-ascii?Q?uVFFs+/bT/uxqwLU/qZ7JGGbz8WrgXRDTQviMRoy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gDlpV+1aomRMIN2r82u+o15ex3rkABaU/lxbZ72XUkbKbFa+axuX2r5SF1hEleVLSWzS0E0USPLsNGA8gLpfmGjNbywrZz/Cba7v3Qghodk7vJ11ZwiHYcIehS36GHf9Bi3P3eH6wTlEsmKN2jzxTFcPb6yme0/H7NmC8mNW5aBWvtMVUaHDchmwgjbEWy5SghxkxzzGywbSJdEM2bByyFBRKWQMoQbANi+YOl5m6u8sN3hmDpzFI+DPidyV/Plw5YOr00KTdfK8FzPsfuIZSeuZhDvjclH9reG1DBiV+AGkCp4c0SXn5HjnlH4j8tgqTdhUll7FdFopiNlo1ClpUuVKdZW1/1OCrkYu5+oqU5sdtlYNBu6TydyLOGhJQGGQSI4wvkI/z955Vj3N0CYop8mXS1fjlBj4bYWHAU4/dgUCnE1lG9Msa4HHPgoEYc3ZSEfZDt2B85N1cxqB/wPjFd9bqmnAGjmV06Gqx519yjg30wJHbG0FE+ySebnhu0Ku5Q1tdl4953k3PgNYvHAJ4+JBuFhAVId3yr7Zt4Jb06yxRU3QPAGsDyeAoZ2l35QAl4m69i2ht6nzaHrTApUUq/YlWUiEAjSRthfCjDNkf/jO4WnvyBPo4YjjcCODG6F2Or3fsUHrujqcCADYMFiGDT4lx3pekJO5WIst0248FiOLUo2taOqtQwAesTe/sXh8KcOTnsdyXbddcr5J26QhXHZ/+gQ2hnDLTLWVgnalQ68aWL53Uis1fd42njlOr1hdZRbHpe3lPlmlCo6WHCi/tneV8jPMBVg0ery+7suOKHNfmMie+sIp8QiosPozRu6SQaeakafDjVJoYs2WaLaVJLaTnpMRP1hGh3ncKMMfC56OdZr53GHwAdRUPiobAdC3
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8073.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8a16a5-580c-4958-093c-08dbc37cfc4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 19:22:57.9109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8NILJwbr4RacleViaVfg7GrR+OeTCIZxKZ1iYs28eW4vXheTatmFatoPtoJPDiS/oupCshO5nSw/cAdZ5/rbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10029
X-Proofpoint-GUID: meL3KwkIcpDKydZO-T8zaJFJCKRCkTLV
X-Proofpoint-ORIG-GUID: meL3KwkIcpDKydZO-T8zaJFJCKRCkTLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=656 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Will Deacon <will@kernel.org>=20
Sent: Friday, September 29, 2023 8:05 AM
To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
Cc: sudeep.holla@arm.com; catalin.marinas@arm.com; rafael@kernel.org; lenb@=
kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.=
org; linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcas=
t timer

On Mon, Sep 18, 2023 at 10:21:40AM -0700, Oza Pawandeep wrote:
> Arm(r) Functional Fixed Hardware Specification defines LPI states, which=
=20
> provide an architectural context loss flags field that can be used to=20
> describe the context that might be lost when an LPI state is entered.
>=20
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
>=20
> Qualcomm's custom CPUs preserves the architectural state, including=20
> keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to wake the=20
> core up without needing broadcast timer.
>=20
> The patch fixes the evaluation of cpuidle arch_flags, and moves only=20
> to broadcast timer if core context lost is defined in ACPI LPI.
>=20
> Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> ---
>=20
> Notes:
>     Will/Catalin: Rafael has acked and he prefers to take it via arm64=20
> tree
>=20
> diff --git a/arch/arm64/include/asm/acpi.h=20
> b/arch/arm64/include/asm/acpi.h index 4d537d56eb84..269d21209723=20
> 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -9,6 +9,7 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
> =20
> +#include <linux/cpuidle.h>
>  #include <linux/efi.h>
>  #include <linux/memblock.h>
>  #include <linux/psci.h>
> @@ -44,6 +45,23 @@
> =20
>  #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrup=
t, \
>  	trbe_interrupt) + sizeof(u16))
> +/*
> + * Arm(r) Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags  */
> +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> +
> +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags=
,
> +							unsigned int *sflags)

Why can't this just be 'static inline'?

Oza: sure, will let compiler decide.

> +{
> +	if (arch_flags & CPUIDLE_CORE_CTXT)
> +		*sflags |=3D CPUIDLE_FLAG_TIMER_STOP; } #define=20
> +arch_update_idle_state_flags _arch_update_idle_state_flags

Usually, the function and the macro have the same name for this pattern, so=
 I think it would be more consistent to drop the leading underscore from th=
e C function name.

Oza: sure

> +
> +#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
> =20
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> diff --git a/drivers/acpi/processor_idle.c=20
> b/drivers/acpi/processor_idle.c index dc615ef6550a..5c1d13eecdd1=20
> 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct a=
cpi_processor *pr)
>  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency =3D lpi->wake_latency;
>  		state->target_residency =3D lpi->min_residency;
> -		if (lpi->arch_flags)
> -			state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
> +		arch_update_idle_state_flags(lpi->arch_flags, &state->flags);

Hmm, I know Rafael has Acked this, but I think this is pretending to be mor=
e generic than it really is. While passing in a pointer to the flags field =
allows the arch code to set and clear arbitrary flags, we're calling this b=
efore we've set CPUIDLE_FLAG_RCU_IDLE, so that cannot be changed.

Why not just name it like it is and return the arch flags directly:

	state->flags |=3D arch_get_idle_state_flags(lpi->arch_flags);

Oza:=20

?

>  		if (i !=3D 0 && lpi->entry_method =3D=3D ACPI_CSTATE_FFH)
>  			state->flags |=3D CPUIDLE_FLAG_RCU_IDLE;
>  		state->enter =3D acpi_idle_lpi_enter; diff --git=20
> a/include/linux/acpi.h b/include/linux/acpi.h index=20
> a73246c3c35e..07a825c76bab 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1480,6 +1480,12 @@ static inline int=20
> lpit_read_residency_count_address(u64 *address)  }  #endif
> =20
> +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +#ifndef arch_update_idle_state_flags
> +#define arch_update_idle_state_flags(af, sf)	do {} while (0)

I'd prefer defining this to point at an empty static inline function so tha=
t we get evaluation and type-checking of the arguments.

Oza: sure

> +#endif
> +#endif /* CONFIG_ACPI_PROCESSOR_IDLE */

Why do you need the outer CONFIG_ guards here?

Oza: this is because of non-ACPI kernel build issue for this config: https:=
//download.01.org/0day-ci/archive/20230915/202309151138.69mFCPtW-lkp@intel.=
com/config
Throwing following

"=20
All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/setup.c:36:
>> arch/arm64/include/asm/acpi.h:60: warning:=20
>> "arch_update_idle_state_flags" redefined
      60 | #define arch_update_idle_state_flags _arch_update_idle_state_fla=
gs
         |=20
   In file included from arch/arm64/kernel/setup.c:9:
   include/linux/acpi.h:1484: note: this is the location of the previous de=
finition
    1484 | #define arch_update_idle_state_flags(af, sf)    do {} while (0)
         |
"

Will
