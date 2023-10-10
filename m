Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23367C42B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbjJJVhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjJJVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:37:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06D94;
        Tue, 10 Oct 2023 14:37:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiMTY011925;
        Tue, 10 Oct 2023 21:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8cvYrKTyRRWBfC8WfOuWsywEP2YicAR1IvbsvAsyZuE=;
 b=TnbobgxrzSVaR2Wp2M8jtlbKul1Tjx5kwD+xwnIF8x8BDfrNSI5qI34cQwLxVKzPfeIa
 vsj4bXlQvrSxqYqJBPNm0DcVEh6ptIGUMY/F7/tKYPDffKn2IZfisAJKZhuWr7hLewL5
 FmZshjo51jYHK1gJVCWgCfy8HmHJHJeZaFi0c16EyTmz508bx6l/z1O4wrp6Foic8lMv
 FJWqA2eMvuV32aZycCuLO47ELgZrik55l37t1WrdaZrAgimHcP6vlecNYpLKTlKhF6FF
 5u2FnJNb6W49VMX4w+KU+Yp8QQmPtoSIIok2CTlRAdNaEnObaN+PmdYBgDuKrAvknK/q 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx26htw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:37:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AK1KYm020737;
        Tue, 10 Oct 2023 21:37:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsd6wd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8raGYq3kszyuVAkn7ljbCLANljEKbOs2in11Eda2THV7ylt4DXq1PXpS6O6Mjxd6jtqesoF5/xYz6Uwd+N85GypgNcS4Jz3FAilaRER88BYMf1ae/KbwiOz8Cvd2Nc5M3oLiGP7CsmYooRvTt82Bmy1fHB/r3iXr6ZYMkcyLt+TCQCirApdFsg+mhXAkYASEaGbzWnyQTdhGGGg90ynwRDWFEwg5eRJ9EsCBx+zovhaR/TknmGaJoEZ6atlKSPgqv2+xo/8GQQiFenWvfr2bASHxJ4RqgbYkxBpK9c3Wh3dGnq6B1lkudYZ9ap2fa77srsh2bqIU1UzjhggPjVLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cvYrKTyRRWBfC8WfOuWsywEP2YicAR1IvbsvAsyZuE=;
 b=OA5Qw8TOhKhKLrZbDlyA8d7RzSwY7G6oze1hPp/UfvX2/Uxz3kkIHssFbs3S/+vBZnEZ3FSGpSGhNZVvfYtxKYVFqjlEH+/7+4peY6uSu7slsqcMsxjzE3Xxz3G8s8AQ+YBuwo9H6HwLyC0Vru+5RZIIzQlRqHacQLLszqGFN06f48I7OlfeJTc8SIzpHfLBHlDcCDqCabHXGuJxOAcrWOM+BMJALWZb1/Tjx+aPqeGX6cctGQGwhWezR/ev3he68n1kHqU3hS2qxc3P48Zir0gX6Ln3JmQVvH2HwLZBa5ubKh6oCfBmoWPr4PDsEZSPBBaR+l3cUrMNrvhH0zabsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cvYrKTyRRWBfC8WfOuWsywEP2YicAR1IvbsvAsyZuE=;
 b=gRkBdK6C119w2MwGqZkqUP5AdJp2/PGB93zF2Q63xEkNjaTqzg6r+EcS99+3LYceSqiqZBW9xUeFdMYEzYS9pJfGw/UNlDrN4UhOk5H7O6t9cd/yGOxX6qLUg1CesLdhxGLiLa8vQfnFPfjHZYQDwNuZUyygbPlPG3lh6pFvlk0=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DS0PR10MB7089.namprd10.prod.outlook.com (2603:10b6:8:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 10 Oct
 2023 21:37:29 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:37:29 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHZ647wLdBfKiOcokm+jxdng1npYrA52wCAgAAQcICACcFUAA==
Date:   Tue, 10 Oct 2023 21:37:29 +0000
Message-ID: <EDCA1804-4CD6-4334-AEAF-A099E5B298D2@oracle.com>
References: <202309201456.84c19e27-oliver.sang@intel.com>
 <20231004084011.7aeef442@kernel.org>
 <C6E5D2C3-D280-4BDC-8DB5-948605ABF2EB@oracle.com>
In-Reply-To: <C6E5D2C3-D280-4BDC-8DB5-948605ABF2EB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DS0PR10MB7089:EE_
x-ms-office365-filtering-correlation-id: 6f0f4a69-140b-4d3e-a3ad-08dbc9d91a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAJEykAaQMYg1pzrcKAk9JYiEwH++XCC/0hGb3QupHCoAmQgnc9LMuBEU3l82M22Ic+AxhAY9NUIjiZIGoeKfA32Pb85EpOE6VCZiA4NZ3yth4ev32NzMTVyVPCgC3tPt8/wLCcvLlPwrc/ghsnAeLMmmI/jdwsH2tPWW2QpdrHsxECuMqbHOHUIwsxxZq0r1k+38obpEazCU/ws0xpbP4o8Kv0elUFNwQtb32a7SVSH+jUoZYi9JiR5pQIXdRYE9hlgEuHWDw+SRth+rxDkJLzO6Yi+2CzftRDz2MCoightsf+0K4mjXzmbjF3Bws/Nf9dxg99WhXpXnu01L2xOC7thp+fq5NQosM63r3yL+Yx2jgox95En1nNSQ/B/nKRVMqYNvdebLdYR/0OuBYLAQUP154gZjSaHvsFI9YKw/CTeaCVLp2+KIm/+AB8BXvQM81U4N6HOLolyyohFUsHSW/y1bST4+rYj5TxTRSF39TLvZu0bueUDiTNnd7fhiKwdC5Fi8o1aZidAeEPkfNI5k9TIMsuGY5k4oNIO5sw0giljj81qdcF9c347PdtiVnzh3sRzSEWn+Uk0UD/lwF6dpFgVcOj2Jg3URnfIJQLnrKvo+h5r1TDEKog7cD13B1gZxAN8Jl8iVu/n2ybb6/FxAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(6486002)(6506007)(8936002)(8676002)(4326008)(2616005)(66946007)(91956017)(38070700005)(38100700002)(53546011)(76116006)(26005)(478600001)(5660300002)(83380400001)(6512007)(54906003)(41300700001)(66446008)(64756008)(316002)(66476007)(6916009)(66556008)(71200400001)(966005)(4744005)(122000001)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YfHE19UO0toVJw/9N9MsTLdraD8sBzQWVP29L5NeBM5rPPXgtwQpw+z7SacK?=
 =?us-ascii?Q?T+RUE7P7DbbX2Ww/6OLQtubMSN+awyY4JQTCPoMTOaJjwTP6rINXQeqW9+G6?=
 =?us-ascii?Q?JJYwMbSMqfQKbQ/ZMw7UKX+g2QTuQ5AX7hKzhZRwqJQZPhV5NVxWUiL5MpUk?=
 =?us-ascii?Q?0h33yr0YZpOhnnP6/lPt8Ew3ugoWNC8dYo+8PyyhlbScB3jb+4eWZVAU864c?=
 =?us-ascii?Q?OO+AmZvDLK9MfiO1v4tAZBnwrwiUUOzjYfK2rkepp2HLsF2+FaY36+5FTECv?=
 =?us-ascii?Q?Q1QwR04Qjlj7WuszIg5pdEL0CK4mn8B9JUqjaDmPto22dojR3Ekx6VZQlpLy?=
 =?us-ascii?Q?irmZf4Y+1GuJyRd5V2Gvu5wXKXWAhDInQh5/b9lLlcKusI0M/7oXN2q3xIGW?=
 =?us-ascii?Q?E3PCQ4cNH84dvOO7SMLY+5yFAsHlT0ry/cSJl9KFJPNzqTTntgG3Y6MXBgBr?=
 =?us-ascii?Q?vv6pREYIn+E4+jbSlCAePRFlR8GOao5//N8KXmQKec9fvFpSseq1KaI57rQA?=
 =?us-ascii?Q?Ta+adTj1UzQ2d3zzSDeFX0QeChxE2Hch4JvWVsDUAO0XGa1AmRWh04BaUiDq?=
 =?us-ascii?Q?cffcpk/nPc08uzdGZ1SkygQKPKNTSK/HIgUYAV8nWMNppHlMV7BWuesz69bE?=
 =?us-ascii?Q?ZfxGJjLD5Xv/8ntbAjGrsRovW+CxW+kn5DogIy9t43cKLPLhmSk5CgYvgmdo?=
 =?us-ascii?Q?wpEheAYydhi8OfNc0XqcLikNa/ZR4pVXHris4/JM9ZjPwxmy8kzTXDn35xID?=
 =?us-ascii?Q?c2+iHZKuZVHgyAcN+6NE5Q238SCwN1wIzLb6BvJoZJRLXIxvC7JTGW2WpYtv?=
 =?us-ascii?Q?SjxZUm8IYroYODJlvjFndcG9CG/7iu21b68Kwsyom1vOY32s+GpIKk9812IF?=
 =?us-ascii?Q?3ofiJIEuo0w7nmIGms+FVn/xN/Z+MZDxDGZvLfo/VrhQOMrts8ycZJAN5we/?=
 =?us-ascii?Q?bLCWvs1uG9NiLsnA8XN6hKzv6xde+E4J2C8l00EzcAAXYn9usFWWOcieivoh?=
 =?us-ascii?Q?MCvyZe3dwIUIfZPwehw/hwBaxNKRG+ac2xDTU+jtapmIj3fB4piMJfP2ED/F?=
 =?us-ascii?Q?W5hd+/SI8pop8QigsJn8f+/+WVD+0bFS0l0zrDL8SX1V38bv2mc1+ViqFtCY?=
 =?us-ascii?Q?NMwkM3d8PIaQg1h4FP6THrIfsBzr2x6uRmytdevzyPks3kB+7koF0Wg4Wuxx?=
 =?us-ascii?Q?kb/bcCvFEl1ORfW/Xd29FsKLcyoXwT562S2V5riz93WOwPR2zlzVAd60qyMT?=
 =?us-ascii?Q?b9WD+ViV7s/wae0K4SRz273uuQkQWO+V0QiaePoeMe7bHUXcED4CbPRXriSP?=
 =?us-ascii?Q?Ceoh/kOAHGGYMyCYRX3vzUUmhV1QampU6rjsyAOx64NshfXrLPpG1MB7Ma7w?=
 =?us-ascii?Q?3KyI32L/DZ98JVXdsiNADQNuHdt9SaEOzELfYr68c5Wv2nJAFepMtf0Xj4AE?=
 =?us-ascii?Q?XUQk797PUgxmZr/ctRcOT87RVvNmDH1WS8Z5z4Z4te0lYcB/V59lUWx/zJTU?=
 =?us-ascii?Q?A5X+r+t/TwmoMP02Gh4yo12uYHZTZjPJhdQExzdQ4+1uPbgd9JSaJ0yY39hv?=
 =?us-ascii?Q?cfPZNO66cdb2Ga0WtGbOF8SMI1Rai0bzcM97Xpay4NFArG11CvFGV7Yhij/K?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <606530A9881C22478EBA592EB6EFEC25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rgj/0v71cXUirjVsCaG7JQrrhJeeD+9SRzc54CZwoBUJLdv2KFw7MuAUrWEkdr8oo7eSu+tlM1GXn6T+fchXLQ+VJ1prmVwg4/F6TSQDMnziePpV/RoiZBn0JbfryJEeRd/ID19BdDNIT6FvOsF4UbpyraIizB4JlSYRC29umiMAaPvk3k4muc5WZYxy/WDa9iqBbEGxlcV+IXRLC2CPMwK27pnEVCo0JT+z1VEPnjZFfFUD8kzuF/ymCt5yXu7YIbVLeSlMPq7BxF0ix4IiIYp59ffj/pMbNOtXnNMF35lnno70cK7y6XQnfU0xmxmMvYJuIztGQinYlZ8F3YyGeJjzjabrqnsIZKJvE+1rePblWFJ976QgPZr0eC4ZA3Sj1+sDR3mGH4sJcf7PHW4OkYPBmXSURqjKbNMwmBUaWpbDMhGKLfwf45TjpN0+rhEx0LOqa41bT5sOvkckKAsPFdXYoMV7PDyX65RFspgP5zoDhvsXwZlt9RGDhNPlas3t9Sj3SWZhjftP43i0p5N97gzlDH+9WyT7dTHmahwAvSjetESxm7FDSMD5CE4Jc3Ns0Ym6ruJ+G+M6mXahuRBTCLjYpk/AwOokqtiPCjn8ytNOA2BelRvoK5sRgNG+nLMf/+zPIt2e1hRgvNV3MECjzGvA1roSUUcelefPxGChah5apSvyqbzFZpAR2sk0tfsh3Mrj/ROLjiUVFDBBUxRk7Bpapcy8eXfgNgrwVwbmLFD3jcnODJkcfpsZLNdnlSYJlTIRGZ8JDjyblhiZLNtYQhJHqYmkeggMCt12JoFqBxTFutkNDupGneQLe1ofe+rksNQnTB5A/EEsCNmk01gPk4aTqItwTqT/fkT2laX7TV5uHSO3VD/GvWSr+PLehBkSRjS8X4HcXJkwoKTOrdfaGw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0f4a69-140b-4d3e-a3ad-08dbc9d91a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 21:37:29.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utQxViISiFmKWAwFaJtDLVAFwgrplaFvpiMrVcF98bZudwIo9tSJLagbcSI8X+mvco6aOWYEeIo2WlW767ojjUJ0gB/IwLYRwD3UcnNW9K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_17,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100167
X-Proofpoint-GUID: YQueAst-pbTOVITNXvtt_-v161k2dhzp
X-Proofpoint-ORIG-GUID: YQueAst-pbTOVITNXvtt_-v161k2dhzp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just sent out a patch which I think will fix this issue - can you take a =
look ?

Thanks
Anjali

> On Oct 4, 2023, at 9:39 AM, Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com=
> wrote:
>=20
>=20
>=20
>> On Oct 4, 2023, at 8:40 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>>=20
>> On Wed, 20 Sep 2023 14:51:32 +0800 kernel test robot wrote:
>>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address"=
 on:
>>>=20
>>> commit: 2aa1f7a1f47ce8dac7593af605aaa859b3cf3bb1 ("connector/cn_proc: A=
dd filtering to fix some bugs")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>=20
>> Anjali, have you had the chance to look into this?
>=20
> Sorry, not yet, will look at it this week.
> Anjali
>=20

