Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29E758BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGSDCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjGSDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:02:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B51BCA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB4YmFL83EfHi9vvz4Kd5Vs6MRO2/RtohGeaxZWrnsbeFAwHfQDPtBHP6F0Zqtx9FzKOSZYylWziC8Q3+9x6Qg6OsLUOMF642BkwPffqWVkJ2Q6Knop1KVPDzqwGq9R/PADvROtlB0CvqMAtU0gDTTeucTpOUrICgjHaRwox82GBybA1wsEXiD5TYV4/XVETf9OkbeD+XP3SEGsR5mMx2EwBv2x+dz2+vMfKdZx22DY3/RPFhtxb4Kh5qCIoJmtredD3WsI1oAHd/tEMK5ZcpdFp7hqkVpj7ajLOQ5TooPL309ExaS8/HRCklZYwithg2wWZohoN/ppl4uyy/9X+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1+VpYdETYAajhqNdKCCQdbdAb1rWOxq9uDmgWCsliE=;
 b=hdUuuNh5V8yxzr+6I2romxqYe3LteT5/MX/UJiGalCqsjGByKchgDB/ILTeuTGhd1ZD0yboLhb9yoJw8C2/hvs+9xiOiCbk9MOdVEWE2kXctdZEjTFffwOe8Qk00LHVJiBcM4Qscjggs6QvfMUZyrHdiYUVAEsR5GppKI/otgqPiDBALSb3JE+CLUmNfZRrfSaZKKVk3nG/oN1iPOdM3pqVluye0mb7Fq3m/WfzfBhE70AuDoLEutoZbnLxUEuxNh06L/1mkBn5Boyooe5a1jzUsoTbkTZlck2nhwwXJpVOIs6GMeqrne34/7QjKJA6p9P5koNgllrkQ0G2ehLAh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1+VpYdETYAajhqNdKCCQdbdAb1rWOxq9uDmgWCsliE=;
 b=epbrupUL6+1PZCis31a+t6WWXFGFUSBaB/nmBmaZPOPTqnGfDPBB7L++NBSXhWGSm4fYY5rPa7ZEvyW8KUIM+/sOn68oYeLWPlvpSxS5G7AIAFz7+IuILwuK+Op+f4d2EEuQF1jtjrwuMzG72p066uvYPhUFsGLP3TWMtbz09aR70delg5XxdbKuHSILVAENp9ZYKW6Q37SALLkcbXvcvCTYPOMzUwfYK/L2uqRcpdMpufP9rtMnv/lxt9dp5i6RWvCZHxf+0ER+UMbrKFsVvXNtY6fl4ocF4/9h/+GjqXcxi2T9/8i8vDvY83luVsNQML5+v7veYdfmsH5Y1HYVLg==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6016.apcprd06.prod.outlook.com (2603:1096:101:f3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Wed, 19 Jul 2023 03:02:41 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 03:02:41 +0000
From:   =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To:     kernel test robot <lkp@intel.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYxXSByZXNldDogaGlzaWxpY29uOiBVc2UgZGV2X2Vy?=
 =?gb2312?B?cl9wcm9iZSBpbnN0ZWFkIG9mIGRldl9lcnI=?=
Thread-Topic: [PATCH v1] reset: hisilicon: Use dev_err_probe instead of
 dev_err
Thread-Index: AQHZuSS99bNd/PZiE0ygRwdI95BOqq/AZyAAgAABV9A=
Date:   Wed, 19 Jul 2023 03:02:41 +0000
Message-ID: <SG2PR06MB3743428C73B543C7DA42FB57BD39A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230718030511.16065-1-machel@vivo.com>
 <202307191040.jWQyBc5s-lkp@intel.com>
In-Reply-To: <202307191040.jWQyBc5s-lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SEZPR06MB6016:EE_
x-ms-office365-filtering-correlation-id: dd360131-c015-4be9-ab8e-08db88049dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H0Af9gUA9yWUfTwOHViJdU0Ncf3pmRH6UAvZXSvDrkCsG9HnBO53w3JcYcz3pM7f9+hwI/zH/rCF2TqWHNCstdDhkMC0CsNvcUsbDX739fADfLzZ49Bsb/JRHavNI7EvYULqLPOrvKzQI/E8i1vkUKapoP6dgd0XLyokUpqvqVaiUl6IRfJorSDoFyRQm9G6L5R/Xh8zyAVKQqmlqU/SKKSPrFZwgtNwpztX5q4pFvw1mf/sMYHGTHR6n80Tjt7zlBBQsCpYfD/aYnasmRUBByS6LNioJzSfvzccw06cJPXC496t5PeEXSmkLDNDk3AqVadRRoUc12Nn7SmMK6jIRMYYKtXqVD3I+Y9PUn6m4A3Q13as5GadvNwwuTSrRPTM4C25N0UrzNzOrQvlrP8ys71k64+PdSkU3cpQgXlX5vPPazT2njOchqKWKrOIyPb6gFYN5+txiunkVfM7638/CxxuVjKnzOzLIKA+PPCF/ZGVQqWKA+yKBnXUH+F82H+hc5VM4M+OEkmedwBvts1n/Gtkq8HPUibCa/zS+Fskz6waITkHjqsVeSC7YuiQ+JQoMW5NeV+dVSruajxGPJT2RHNsDAOexIxopkGpHYCX/rg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(38070700005)(71200400001)(478600001)(186003)(83380400001)(26005)(6506007)(966005)(9686003)(55016003)(86362001)(8936002)(4326008)(6916009)(2906002)(316002)(41300700001)(7696005)(66946007)(64756008)(38100700002)(224303003)(66446008)(122000001)(66556008)(85182001)(33656002)(54906003)(5660300002)(76116006)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SE43QU40bHQ5SHIrY3B3SDdOalVhS3dwc3IvMmROcmttcUtINDZpTFN1Vndh?=
 =?gb2312?B?YW9xU1lZOHlQalZzbm9yMmVoUE9DSG92U2grZmZMTEJCRUVJMXlERzRmbHhS?=
 =?gb2312?B?WDZGNGFwMnVsckV0THFVa2FwNUN1YnY3QjNoQkYwRjltLy9aRkJ5dTVvVmRD?=
 =?gb2312?B?dFZUb1hYUGxVdjMyVGdDQUMvRUFERmdqWkZnSWt3d3JYSmNWc3FOajUvM1pU?=
 =?gb2312?B?cnFRNjl3c1NwdVRlTXlHa2MrTmxsa0laQVJ0RFBxUUJ5bjFsdEJpL2VBM1NS?=
 =?gb2312?B?dncwRVdDMUViNVl3TlA5dHhSTEpyTXNNTllBNWxyODRoWTR4YnNSQmwraW5J?=
 =?gb2312?B?ZWd2UU16WDRWdkRnYWRuVUoyZ2JFZzFFZmZlWHdIV1ZQWlFvdG56Q1FQamx0?=
 =?gb2312?B?NDUrd01kYTNYR09BeitqN3hNYWZVY0ZabGIzRlZ5MTFyclVFcUF1S1hwK1FC?=
 =?gb2312?B?WlNPdUxmR08zK01LV0lSRlFFSVZBOXhjdWtjeFZETTNaVG9nZSt0UGpFQk1M?=
 =?gb2312?B?aTJRK2hwa1NFMFVKSE10a1gwazlURysvZEptaUhQYytSeFd2VDhwOHhWR0pN?=
 =?gb2312?B?WDZSZUhLUFl1ZlViZW5EbEtCNmtUeGFBQnBBZno0cForSDhOck4zYmM0NndQ?=
 =?gb2312?B?NnFSVm81bGdtdDRmMEZNWXlXK21RekVoTlpTV0c2dTgybFBlNHdtMmpvSGxK?=
 =?gb2312?B?Q0NJUit6dHBZcG5IL2EwZHF6azVnWW1VNWg1RHlNOUdpdVJ5UUhWb09UVWZt?=
 =?gb2312?B?cCtsQ0lSc0RzUitKdVdhemQwQTlCd3FaVXRzT2NqSjVkaGRWSVdDZ1N5N0Rk?=
 =?gb2312?B?RUJnZ3FaeGk4SU5xeHZjZTd4TzEreUJUYndWOEdHSUlaTGJyck1YMUxPU1VQ?=
 =?gb2312?B?UFRDQ3JiSUJWLzl3dVFham5DQTA1VHduSTBkU0ZLcG1BemNvQ1FPaGhwZmNS?=
 =?gb2312?B?d3J1SEZtWDFraVpHL29STDh4WmVTNWlQZXR4L2dHRDJlV2FYd3RQN1E2SE5y?=
 =?gb2312?B?bUhyandjVEJoOE5FZGpyeGlzYU44eDhWWnFxUkltajIxN29hSWp3dEtqaDJI?=
 =?gb2312?B?OEFRdHZleGtoTlppQXR6RFp6K0dENnRTdTY0M3dWTFBIbExrWU45OWtNK05J?=
 =?gb2312?B?NVdWTHhhazFIbHJ3TFd4emsra1dQOEhrZkVQcjVsT2ZBVXRwUHV5REk1SHBj?=
 =?gb2312?B?bXNFWFBCQWJ1NFhlV2Nta3BmTE84WkpHKzZxT1FZSnZvU05LUlBuaGk0MjVp?=
 =?gb2312?B?KzgxQ2ZBYU5JSFE5QTFFRm5ISWdzQXRwNlFMTlRxQWZiUnNvWDFCQzUzSTlX?=
 =?gb2312?B?RUIxNVJ6bzN5VEsvU0xMQjljbFNwS0ZSODlxT0FKVzFycmx2YTZFVW9lWEJC?=
 =?gb2312?B?ZjFTMVhQU0EvdjFZcDUweURVTjFKMytMMWVTRGtvOXo5TVFieEJFRGE5QXRC?=
 =?gb2312?B?QjQwVFBvOG8xS0JXQ210L0N3OU8wZ0NpVVo5RlNlV0RDWXRLOElLWjVnSUkr?=
 =?gb2312?B?NVI2OHd6WFEySWJpVTFqUjVrQ1pvQTB6bjROV3krdWkwWEVtaUhaSHBzZU0z?=
 =?gb2312?B?SFcwSzdkS0RkaW52NWtSVlRzM1ppVjlNRXdxbENLYUoyZENzaU1COVVnd2dv?=
 =?gb2312?B?aHJhR3M2Y203aWd3Z3FGd2VqSWRKcGhTU1JmNjZoZThvMjJnTlh0NExvWUJQ?=
 =?gb2312?B?RDU0eVJFTkpkcDFIQ0Q3SWxhbisvYVM3eEJXbGU2bkpWSlNTZ3lnUlBqYi9H?=
 =?gb2312?B?R1RWR0trb3JMSVR0YXNlbE54blVha0dNdEI4OUhFK1ArYVlmd2dtdEpNOVEw?=
 =?gb2312?B?NFNvaTRlbFE2ZW5Qc2ZiM2ZSa25vMVk2T2VDdFc0T3BNcTBvREFTWjJvcFlJ?=
 =?gb2312?B?UEFPVGF3V2x3UGR1RXJudXBmYk92eVdsUzRRS3JTUmw0d2hNTnNkRGxFK3RT?=
 =?gb2312?B?ZVZZZ2prV0NMNU9vVldWTFllZnBTcUp4UFl5ZktmU2ZlUTJhL21jS1FPeU9U?=
 =?gb2312?B?QkVpY3I2MjFCeVNicml3TGlJSjFSRXFZTkc3dkt5d2U3MHlFc2JXWmw2N29a?=
 =?gb2312?B?VzY1MXVSVUZYbXJZMXRqQ21KQm9QV1hpQ0tPL21GZ1Q3WHVPUUQxV1N1aHlY?=
 =?gb2312?Q?1DeI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd360131-c015-4be9-ab8e-08db88049dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 03:02:41.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StbpRr/PrSx+KxrXSoFuPpv2Tyfg0YIgFUXZgS2PvDqVIk3dW+Xtx00dCBB+1XsNRuYqYg5vFzMMODd18h2P4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSByZXN1Ym1pdHRlZCB2ZXJzaW9uIHYyLg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7Iyzog
a2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+IA0Kt6LLzcqxvOQ6IDIwMjPE6jfUwjE5
yNUgMTA6NTcNCsrVvP7IyzogzfXD9y3I7bz+tdey47y8yvWyvyA8bWFjaGVsQHZpdm8uY29tPjsg
UGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCrOty806IGxsdm1AbGlzdHMubGludXguZGV2OyBvZS1rYnVpbGQtYWxsQGxp
c3RzLmxpbnV4LmRldjsgb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8u
Y29tPg0K1vfM4jogUmU6IFtQQVRDSCB2MV0gcmVzZXQ6IGhpc2lsaWNvbjogVXNlIGRldl9lcnJf
cHJvYmUgaW5zdGVhZCBvZiBkZXZfZXJyDQoNCkhpIFdhbmcsDQoNCmtlcm5lbCB0ZXN0IHJvYm90
IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvcnM6DQoNClthdXRvIGJ1aWxkIHRlc3Qg
RVJST1Igb24gcHphL3Jlc2V0L25leHRdIFthbHNvIGJ1aWxkIHRlc3QgRVJST1Igb24gbGludXMv
bWFzdGVyIHY2LjUtcmMyIG5leHQtMjAyMzA3MThdIFtJZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQg
dG8gdGhlIHdyb25nIGdpdCB0cmVlLCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuDQpBbmQgd2hlbiBz
dWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBhcyBkb2N1bWVudGVk
IGluIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNoI19iYXNlX3RyZWVf
aW5mb3JtYXRpb25dDQoNCnVybDogICAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3Av
bGludXgvY29tbWl0cy9XYW5nLU1pbmcvcmVzZXQtaGlzaWxpY29uLVVzZS1kZXZfZXJyX3Byb2Jl
LWluc3RlYWQtb2YtZGV2X2Vyci8yMDIzMDcxOC0yMDMwNTUNCmJhc2U6ICAgaHR0cHM6Ly9naXQu
cGVuZ3V0cm9uaXguZGUvZ2l0L3B6YS9saW51eCByZXNldC9uZXh0DQpwYXRjaCBsaW5rOiAgICBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNzE4MDMwNTExLjE2MDY1LTEtbWFjaGVsJTQw
dml2by5jb20NCnBhdGNoIHN1YmplY3Q6IFtQQVRDSCB2MV0gcmVzZXQ6IGhpc2lsaWNvbjogVXNl
IGRldl9lcnJfcHJvYmUgaW5zdGVhZCBvZiBkZXZfZXJyDQpjb25maWc6IGFybS1yYW5kY29uZmln
LXIwMDMtMjAyMzA3MTggKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8y
MDIzMDcxOS8yMDIzMDcxOTEwNDAualdReUJjNXMtbGtwQGludGVsLmNvbS9jb25maWcpDQpjb21w
aWxlcjogY2xhbmcgdmVyc2lvbiAxNy4wLjAgKGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0t
cHJvamVjdC5naXQgNGE1YWMxNGVlOTY4ZmYwYWQ1ZDJjYzFmZmEwMjk5MDQ4ZGI0Yzg4YSkNCnJl
cHJvZHVjZTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMDcx
OS8yMDIzMDcxOTEwNDAualdReUJjNXMtbGtwQGludGVsLmNvbS9yZXByb2R1Y2UpDQoNCklmIHlv
dSBmaXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0
IGEgbmV3IHZlcnNpb24gb2YgdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xs
b3dpbmcgdGFncw0KfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+DQp8IENsb3NlczogDQp8IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwv
MjAyMzA3MTkxMDQwLmpXUXlCYzVzLWxrcEBpbnRlbC4NCnwgY29tLw0KDQpBbGwgZXJyb3JzIChu
ZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQoNCj4+IGRyaXZlcnMvcmVzZXQvaGlzaWxpY29uL3Jl
c2V0LWhpMzY2MC5jOjkzOjYwOiBlcnJvcjogdG9vIGZldyANCj4+IGFyZ3VtZW50cyB0byBmdW5j
dGlvbiBjYWxsLCBleHBlY3RlZCBhdCBsZWFzdCAzLCBoYXZlIDINCiAgICAgIDkzIHwgICAgICAg
ICAgICAgICAgIGRldl9lcnJfcHJvYmUoZGV2LCAiZmFpbGVkIHRvIGdldCBoaXNpbGljb24scnN0
LXN5c2NvblxuIik7DQogICAgICAgICB8ICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQogICBpbmNsdWRlL2xp
bnV4L2RldmljZS5oOjEwOTE6MjA6IG5vdGU6ICdkZXZfZXJyX3Byb2JlJyBkZWNsYXJlZCBoZXJl
DQogICAgMTA5MSB8IF9fcHJpbnRmKDMsIDQpIGludCBkZXZfZXJyX3Byb2JlKGNvbnN0IHN0cnVj
dCBkZXZpY2UgKmRldiwgaW50IGVyciwgY29uc3QgY2hhciAqZm10LCAuLi4pOw0KICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgXg0KICAgMSBlcnJvciBnZW5lcmF0ZWQuDQoNCg0KdmltICs5
MyBkcml2ZXJzL3Jlc2V0L2hpc2lsaWNvbi9yZXNldC1oaTM2NjAuYw0KDQogICAgNzUJDQogICAg
NzYJc3RhdGljIGludCBoaTM2NjBfcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAgICA3Nwl7DQogICAgNzgJCXN0cnVjdCBoaTM2NjBfcmVzZXRfY29udHJvbGxlciAq
cmM7DQogICAgNzkJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsN
CiAgICA4MAkJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiAgICA4MQkNCiAgICA4
MgkJcmMgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnJjKSwgR0ZQX0tFUk5FTCk7DQogICAg
ODMJCWlmICghcmMpDQogICAgODQJCQlyZXR1cm4gLUVOT01FTTsNCiAgICA4NQkNCiAgICA4NgkJ
cmMtPm1hcCA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobnAsICJoaXNpbGljb24s
cnN0LXN5c2NvbiIpOw0KICAgIDg3CQlpZiAocmMtPm1hcCA9PSBFUlJfUFRSKC1FTk9ERVYpKSB7
DQogICAgODgJCQkvKiBmYWxsIGJhY2sgdG8gdGhlIGRlcHJlY2F0ZWQgY29tcGF0aWJsZSAqLw0K
ICAgIDg5CQkJcmMtPm1hcCA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobnAsDQog
ICAgOTAJCQkJCQkJCSAgImhpc2kscnN0LXN5c2NvbiIpOw0KICAgIDkxCQl9DQogICAgOTIJCWlm
IChJU19FUlIocmMtPm1hcCkpIHsNCiAgPiA5MwkJCWRldl9lcnJfcHJvYmUoZGV2LCAiZmFpbGVk
IHRvIGdldCBoaXNpbGljb24scnN0LXN5c2NvblxuIik7DQogICAgOTQJCQlyZXR1cm4gUFRSX0VS
UihyYy0+bWFwKTsNCiAgICA5NQkJfQ0KICAgIDk2CQ0KICAgIDk3CQlyYy0+cnN0Lm9wcyA9ICZo
aTM2NjBfcmVzZXRfb3BzLA0KICAgIDk4CQlyYy0+cnN0Lm9mX25vZGUgPSBucDsNCiAgICA5OQkJ
cmMtPnJzdC5vZl9yZXNldF9uX2NlbGxzID0gMjsNCiAgIDEwMAkJcmMtPnJzdC5vZl94bGF0ZSA9
IGhpMzY2MF9yZXNldF94bGF0ZTsNCiAgIDEwMQkNCiAgIDEwMgkJcmV0dXJuIHJlc2V0X2NvbnRy
b2xsZXJfcmVnaXN0ZXIoJnJjLT5yc3QpOw0KICAgMTAzCX0NCiAgIDEwNAkNCg0KLS0NCjAtREFZ
IENJIEtlcm5lbCBUZXN0IFNlcnZpY2UNCmh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9sa3AtdGVz
dHMvd2lraQ0K
