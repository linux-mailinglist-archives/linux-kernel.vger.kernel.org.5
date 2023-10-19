Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B47D01FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjJSSqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:46:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC8124;
        Thu, 19 Oct 2023 11:46:20 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JCkOId008134;
        Thu, 19 Oct 2023 11:46:13 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ttshuc3rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 11:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wunjn6MWS7Wgqh6vqg0tzPrXq7gOXQv8kSoG5wF1XsovkQO6boSrFH3dzajlQ8eGrR05DodwVdHW+9yFSF7+1M0APGVOu7fyg5I7g78Y/8rEsIBdbLJYYi9mb0ydRR1nOSuT58LK/8eZQfaAt6uJhGN/qDfqJC35y16kP9XjXCbrcQ4osLtLyWBRR05EBSPN4Ec91XsIZkpFKH9QKYmC3ZprnPklr7wBL3vLov5WTAnV6YmBMTPNOqyVW451eZvjzmNsaYQNRLVIHM5WAQ9yC7AeFfFEnfjHYOSkkyPu8p6jk/K+vLS9IxmVfRwYL3nSSI8cg6xnksBm8KrV61tiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPtJLfJIuto2sp+jKyTFRHbA4vZdl9dXks8WMomGjrY=;
 b=U6qhrJPC74UB+oKUC1tnWY/cd5TAwCArPXeg1xt28waw4LMVf0h+UHb+kOT3u12anoQN0aF92x+pdd7n0oNf8gg1hxw5ixkTaYgIQXntfD7ZfOcCd+Gyvc3SVOGZ4Q/nuO8zMzmkIf1h8aY/F46bbjWURP1M9Bj3XvmIuuYBfwgvBgz0NBJyW3l6QHVqVxMb+tzInKQvfiz3ynXxp0Vhcq1VBVv7YgmZ5cJdNhH9C5C2N+EAHJhbDD0H5Myn80Yfw2iUaTpCtGIMORhumV6UOp7SS1opzOarpvxdWqOHgTSGXHh4K6CKIgBcjpStkRhYXj2BVWfCTAGN6jtpaIP5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtJLfJIuto2sp+jKyTFRHbA4vZdl9dXks8WMomGjrY=;
 b=EqE/HHv1e9skP0vrrBitBOFcRS5Y8eA6LDYKpEBzia5B7ZPvURtgxoK2maii47qzVGwslJHouxVcXeIofSV/c3SXd31++BS9/+hytwNyYKfUpverIa8+Jocia9hy35tL3ty+laLn7h7dhnMu81XZKDChCF3+HtAds4qL9/k1ZAc=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by BL1PR18MB4165.namprd18.prod.outlook.com (2603:10b6:208:310::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 18:46:09 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 18:46:09 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "horms@kernel.org" <horms@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Haseeb Gani <hgani@marvell.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sathesh B Edara <sedara@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Thread-Topic: [EXT] Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Thread-Index: AQHaABIUJ5/HUS8g4Eig936RtZ8cVbBQP/aAgABYbq4=
Date:   Thu, 19 Oct 2023 18:46:09 +0000
Message-ID: <PH0PR18MB4734672BE30C49F09E2C7D65C7D4A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231016092051.2306831-1-srasheed@marvell.com>
 <20231018170605.392efc0d@kernel.org>
In-Reply-To: <20231018170605.392efc0d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|BL1PR18MB4165:EE_
x-ms-office365-filtering-correlation-id: d09650ee-7d1d-4172-d22b-08dbd0d3a8f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRV6atAPS2+BfEyuM/vpDC/+Oh9+95njKMH6z1X5pAgfw0cYrxhIObMSKMfnqNnsdlAMg+YDydMedZkYh/lYBXsTQYUqCJBybKELW232Jp0vx+Gz1uMG1GfIazgFs4vAhZUiEv728EFdyFlu/D+dmoGoJtLWRLQlC9pp930FPyUqL0e9vak+hfiyJDMXqH5HGUrE6bWzw6iXYRTqBh3ZyfNEPgiBbfB6/fp7ACp4Z57KLKOJp/AvBIzRS80yIAQCMzjkU9oRSILWu47HVAgYUMjRot9hBjQwNe/ITgP7uW//kLrL/PZFvi3l1iNMRGiL9Ksd1A5jqvuT7z2n0P3Z4wstl63Y7oGf3lxPTYLhDgv956WM7UUfZfFtoOrphCf/LHLtXZfmGofJLtPNX5ZjmPvjnXvacpWXQCx7z7MyKiz4hubdgFlGaiqi1yY0rZIfejKOfpky/O6WtX0rbQIXpUunWL+eyzWerRkKbghtbZKULutzLSm14LO/X6gumg8JYoUWgFjpKRbLzv/kvb3L6xYLEbVcMR2iOVwEFZn25hWYvMOcBHvT4VZNUYWTQLNFGf/8uk3Tdq/0d6PcX2Ez3BCT/kbR29UnD3q+J4UuZZTZg2iog8Qt6vbuh4qIgzU9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(26005)(38100700002)(55016003)(6916009)(54906003)(5660300002)(66946007)(66446008)(76116006)(64756008)(52536014)(91956017)(8676002)(4326008)(8936002)(86362001)(2906002)(66476007)(66556008)(558084003)(71200400001)(7696005)(6506007)(478600001)(33656002)(316002)(107886003)(122000001)(41300700001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BW3QmEFFhtlWpXUY4dmn7y8ST3cC+KJoSgSKtV4VWw4tliYj/n2tX5wZmB?=
 =?iso-8859-1?Q?2AMfEgy+jbP1/9R6z78dOKdC2b3O7iGNPHOQwOcr88V5RGvipzYhan7dk+?=
 =?iso-8859-1?Q?/pnUfPb0GmFK38ZtuyCN+cUP/9Lflf4IeklzfOA7+PXspPRNLH/GNPMZVB?=
 =?iso-8859-1?Q?tJ/FUwy3JZubaxrCYTCb4RoypDbifNBkWCeUL0VnsbsOMHBB07b1/6RJiQ?=
 =?iso-8859-1?Q?Wu4nqi1PH7AJ2LG7LBuMXhYOQBTyqQ2Og6UibW5YGlka4DarLvP6196xDG?=
 =?iso-8859-1?Q?V/r+n20tcqLihR2QbGKE/0BoghHtseOaqUTgZ6pmzMiWcCbQCeZMged01y?=
 =?iso-8859-1?Q?eXFiQR1fVYq8u5YZ9jnduBQjNOloU+fSCX8j7FWFdLuBVC4K6kr9j/GbVp?=
 =?iso-8859-1?Q?qyxj6EclWA0O2qFq31OXz6poWd3en2a/VpYK8FZJwYa8gORTrPtN3/vn5y?=
 =?iso-8859-1?Q?V5UjBXdgY0pFOEqbEisOtzuFzT/R1yWKRBYc1/Ur0S6wtlyNrweLuZuZmJ?=
 =?iso-8859-1?Q?JcLmjhCp9uKja6yWeDyevWhDtFnBjPs1o4vitc6E0BYJucD0XklqQytd3d?=
 =?iso-8859-1?Q?p+XKayEj4lg77CNRDIXU/M00Gmhvwg/Lz8pY+sq6zHYXeDRsmLrYr6ctWR?=
 =?iso-8859-1?Q?ujnHnRepk5H3QPIF4QjKGyIEtAJK1+onOhjlv4nhaRFP8N/d3z2nrMuJuc?=
 =?iso-8859-1?Q?vL8NpG+uOtDCVUvKE0nTo+FpYIy+ZdY8Gf0iRVjw0kTeISXW3FP0e0W4/q?=
 =?iso-8859-1?Q?/17/dwWPegUz4rm7010fcOKbYW+PHQ5TlLsNtugSvhsEV6C315A0lShsB4?=
 =?iso-8859-1?Q?buBfw8PE7vHctdkxYUQepcTGIIX+OqcvmICq3VdIh/jYG5KA89tt9FbeGK?=
 =?iso-8859-1?Q?S7a+m5NV1x4p1P5hA5ChsamMVeXfFvl5PWcr4kj279vbkvK4+xEezvKqsj?=
 =?iso-8859-1?Q?U/FdEuWlZU0286z2D1jC5ZSgVTsfgxNtpxr/0Xe4kFnANjKfff+oycrj+d?=
 =?iso-8859-1?Q?ZfBk8p3hi4cQishBSOOujhVuOh1/cQ9fysxWskBIdMmHGZUpnR60eqwwrG?=
 =?iso-8859-1?Q?flMDKemXQC/5Oo1IzaIdmSYqXBENToSO7AXBaDZZuyh2nv9OPzpRdYdlDP?=
 =?iso-8859-1?Q?L/A/8+DoNDTzebL7WJxjaV7o5W4JkYQWYwstXdDN6ucOxH/zfhl+YiwVcu?=
 =?iso-8859-1?Q?BamuplPcA/rAHkQ4CfVHk4oH5tVQVjA3PzrvzWK4OzxGkbOVwSHg3Wp7N8?=
 =?iso-8859-1?Q?xDuHOY3475SXzFVBKihEra+aVeIss9RqZEPCRhfd4OCzohsYQ8v7kUwwDj?=
 =?iso-8859-1?Q?g4MpdKMAJOO1PM00Gw8CMDCXhYUSnyR8Mmdlj+mvuNGzBrSBlOWGdVoeZf?=
 =?iso-8859-1?Q?59IAynKf4Vh4XmwRC241g8LnwvtjGhs78B3bxtR5BA2dQyzY4+QSVSnKPz?=
 =?iso-8859-1?Q?lYwVShVIhs5cWggjJDe50XBpYXj7tClwiZnbS2hAoFlf2NMneVB4c1scLn?=
 =?iso-8859-1?Q?uWLGv2MBO0IdaDPPi40BUDZzKXXoUPEa1LFpnQqu+aom1NOOn5F0XD+V4v?=
 =?iso-8859-1?Q?+6317PmBCmbkvRr8DUPmYESEExgZW9E7xvJAQf1eWw3A6uCCJ36nBJtyG8?=
 =?iso-8859-1?Q?UY6i7vJlM12O9HOtHcSbrscn68uQoXxAky?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09650ee-7d1d-4172-d22b-08dbd0d3a8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 18:46:09.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aTABF3lM/Q6fHaHHOOYJbnBiqayhB/VGxXQlesEZG/BC7poJRACuBFS/tUoKhHbbEf85iqTTp/LON6/Ol1atA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4165
X-Proofpoint-GUID: L9zBjJGZZEjEVhzJw-a30EFWxTTeUxFg
X-Proofpoint-ORIG-GUID: L9zBjJGZZEjEVhzJw-a30EFWxTTeUxFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_18,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,=0A=
=0A=
Since these structures represent how hardware expects data, there can be a =
lack of alignment. I'm afraid static asserting all the hardware data struct=
ures might force some compilers to fail? =
