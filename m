Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB0678C854
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjH2PLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbjH2PKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:10:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F50A1BB;
        Tue, 29 Aug 2023 08:10:52 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TAx7MQ032182;
        Tue, 29 Aug 2023 15:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=V6P6IgT4fq0Nz4ImFAX59N9wLTtH6dQB2NaQ9LCENME=;
 b=paHHXCyf205M5ITC8xwRDl84DaHYkXYiNLkWlXfOMZDXl/GUfbFwx8MfX0mQuq81j5F1
 I91f9dSSxElVQOJBdsfnO/jtc0ve/D5bKDxPVaLar9gGb9cl0/TQu2B55iQWtjYPi7KO
 dHC5yjGkH+YX6Euu3Up+EsAL0KtEZdG7ZKcNRxeW1VLhVSmp+U71xYW7eZgP5EGzcIRX
 pWHalczib+dbqJg5rPIUBn8q2jiJwdzy0YyT7X0sIaTQpZM+XV0qnD+K4CGQikBykzBg
 Y5+pW0KtsH3iG7bAkJ8XjUJ9K2Fbur2RIo/gNQwHUpzalIImT9Iy7Q7bbzspqOjiTV/h 9g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss6j89nj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izccc7aTLtOBRy6C9T6aLolRAS3XM6dsAhZ8Y0KIImp3TZKM2Q0qmXCluuY+prtg/pa0xJZ3J76qhNOBNtJLLZG6GMplDQtiJdhSIUjH8SYcrYKu7yNlLBnGJ5jvGm59799woJMAoFKcp7elLKdJD/PoFlN5+9LAORiQspTcqaw6IP+3ZvPmjKHH9C+k5UxenxfjjLLpMeSSautIXZ7AUd0lAEKc3YiMyWnKHPCXePBDGVpGrRHeXMZia6tiW5rAMmEwszCQ3N1jv/S2TrKFaB94P2cUGbDdPWI5yVaxwndTkJIDUcfbQD17/hOhJICS1MRn5JDyRc74qHNSW08EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6P6IgT4fq0Nz4ImFAX59N9wLTtH6dQB2NaQ9LCENME=;
 b=Rk5fltOopolsGpeieD5hEwaHUPLUbSnhDc/SvgK8MYrLr5iJ0nxoegxXthkVhkHcxKUodD+N02ANVOSJSWJLHs6/PRBCvRhgVkQs+GdI2O2Bdd8eKxX4Ti7JGZ4T4NsIeH6PnLiiykfOxiLoo2hjV6xGie6AkrTDIBBkqBU4w0Zb0GDnLWqie6b0BRxOSYoyOOsxbsI/kz+wVvz5RStsDLt1gjY3qbhNrbyhyz0/7+6VBegKqp+t9/wPruu1yOFUSU/K9YY7Gl8Q/PPlZci7yj0JaQQQvoRfZ2T4+jGv4cIcLGEPVmteit/3lBtbq2ThoFxfMfRIR4pB84u0+HKsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CH0PR02MB8073.namprd02.prod.outlook.com (2603:10b6:610:106::20)
 by CY8PR02MB9083.namprd02.prod.outlook.com (2603:10b6:930:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 15:10:35 +0000
Received: from CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::3d62:6828:e5de:a985]) by CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::3d62:6828:e5de:a985%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 15:10:34 +0000
From:   Pawandeep Oza <poza@qti.qualcomm.com>
To:     'Sudeep Holla' <sudeep.holla@arm.com>,
        "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: ACPI binding with SCMI
Thread-Topic: ACPI binding with SCMI
Thread-Index: AQHZ15v/XxjdIx2eokuNoiWET0Kgs7ABBIYAgABgCVA=
Date:   Tue, 29 Aug 2023 15:10:34 +0000
Message-ID: <CH0PR02MB807367CCAD0D5938C4679E18F6E7A@CH0PR02MB8073.namprd02.prod.outlook.com>
References: <20230807154834.888328-1-quic_poza@quicinc.com>
 <20230818091931.iqh6bxiifk4wyc32@bogus>
 <CH0PR02MB80732F4C4134B3EF2D80B4EDF6E3A@CH0PR02MB8073.namprd02.prod.outlook.com>
 <20230829091912.xefuenspdbazvqlh@bogus>
In-Reply-To: <20230829091912.xefuenspdbazvqlh@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8073:EE_|CY8PR02MB9083:EE_
x-ms-office365-filtering-correlation-id: d69a3efd-22b6-4ffc-b38f-08dba8a21834
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/z2V+2oLBr5NBiZHeiMHCmlMyWgeuRCuZJZctRyU9lcspqIZt8QPGXXOGlShY/MP1zy/sp+5kFwXo34m9n/0tM380AvBOEhirvgQjcLGVI2Rp8sRtGjfry+RH6gkjjjOj+z0Y+MuXKJbm+0ZPPMtBVbwU5XTXoO8dH2ifiXZ3zdVdsjj0+FsljSAw05pIJTzDpSehNQMiIgu12TR7VWD4/l61OMJMS2VGEeZJaYr7tECd+rT/JdhC28tOo3t4pJ8W6wx9Osufjk3btzuPYVqHD2PEccMKyum3+yNEWx/B6k+Rs65NQX9phcFPxSzNqtPPUUGrkMO+fhZfgylypTNQNd1/hfENPR4JCvTVC4hwuEJqUOP2Sto0W2z3FtKvttzgu7AzhN9ZZhrutY2rD6aqRUUKPdxXTJWD2IAVmJqcTf0k5PFza+ORUcRLfBXcLeymwCfJzLjLIxHF2AA7LybK8aBvto9MMegc2uAvpNrqCUz3cHB20Pt7SfYyXyjkG9W+jon1sHI7B87yu8K3GPHZ5gFhyALHVturI9N/xNqpVlHT23Wm10K81acfVAgJfD1j1rkJDYsOIWMp3jUFMHdHkWL2FOojFafibCQ3LaFLcGCId/H8r3q4k6Omy8Ni3g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8073.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(7696005)(316002)(76116006)(5660300002)(52536014)(8676002)(8936002)(66556008)(478600001)(110136005)(71200400001)(54906003)(9686003)(4326008)(2906002)(66946007)(53546011)(6506007)(26005)(66476007)(41300700001)(64756008)(83380400001)(66446008)(3480700007)(86362001)(122000001)(38100700002)(38070700005)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Be752VH4Kl4CCof3Rc2f1fgL/JLRYd8YrkprWE83Ix2VUwzeB2S/mcHxyzeC?=
 =?us-ascii?Q?gCB7KvzqIYr94GVYMtuxWn06EYXVL0j5mGnOzgSGWYwUcI+hJdRBSM7MW7kP?=
 =?us-ascii?Q?/nG4otS5zfNGNswn8MbYrfhl7RIMrIaYKty/XLoguwD5efqTy0wBVOyyfo85?=
 =?us-ascii?Q?MWVP31LYNCkZFfMW/pJ2V6y3uvFTTIbFt4WQafLu9WV3/X1EM+luJcG5OMIR?=
 =?us-ascii?Q?I2uELhDKsEO/S0kA7bShevAz7AoKpD9BvdlVLCfOpxsSnlYXo3FWE3OxEq7C?=
 =?us-ascii?Q?Jndc8tZC5sXe3iPIBRy23kpyyNhczxP7j10bnZ89ci/elVshCKASV1KRCEGL?=
 =?us-ascii?Q?0Qpm2zP9grDccMc1NN9z34AjTBZ94hhprlKCY8gBQG+RPHuNG+W509dUiOvb?=
 =?us-ascii?Q?XfqcHVyfXZlOTtUkgd2d5/k68bA68c726MrOvacR4QUT1Sfe+GM3c9vEVZwX?=
 =?us-ascii?Q?TV4uI8PeK5fJINVeRy4lcCpX9m9IDpK6VPQyxW7+19bHje8h58gpE/LfLzAW?=
 =?us-ascii?Q?r2JFkyCLWlwVcf4FP8KWz9NK5w6zcHLKAWSPTTOCT/SoDq8rw/bZD3hYiFyu?=
 =?us-ascii?Q?4YZgr3S9WagwiUuw+W2MqHHDfKzIs7TR+y0TlKWVSJultBz8x+M6E4GfbO5Y?=
 =?us-ascii?Q?XwHtL2wvDjfeALtXIBGxtHaK7ApmiIzKv3/tfXZyuuo+6NGOk3CKcKH+mnHX?=
 =?us-ascii?Q?yL/raEzG5le/J8eX0BIKw4D9CyK+JBEoG3M9HbnVhKQXMKnxzWF3tcZP9LnJ?=
 =?us-ascii?Q?Wsbm+5j5zFKbPmLBEKN8ITW8fjKVDiNx9Q7hG9I29BZjfI7NVy5dR9xj1NCI?=
 =?us-ascii?Q?URx6ICHfENAQ61j9/nKBR8Jn6lDsvQHCoMszV6Chnl10jX+m82L4n+W5aWOo?=
 =?us-ascii?Q?zF9vNQiWko2TOYtUFzMNolgfj/4KqlHuEyyVo/mRbM4nWyM9uTyY4EVvr5MO?=
 =?us-ascii?Q?ljBfFFZCx5MdeAc7fY5Rd7mF1aYR0a3Z8jUcMnlCsWs4kVLJQPKZ9EOzdL0a?=
 =?us-ascii?Q?d9Xodz2IKSIy/LLWauf/jFLPJad1GDoQGCuz2qGHrWLJOecVSrfB32MOEJH9?=
 =?us-ascii?Q?Kd6YH7q3icSlUgOCAz2LQOecYWn/S7hTHyLjeOlMLV1WAkFHCPI7OszGN9BA?=
 =?us-ascii?Q?kdQlaf3QgEwnwF85uQRXEVOdK/HAchgX+tO6m15IqTwOLIiZJ/UhJ3nS1syY?=
 =?us-ascii?Q?saBXqCCemq1rWEyDkxtNwfBo1B+z5o4UCl9tuuVvCepU3SW1y6xwZT7L3e3f?=
 =?us-ascii?Q?pOe1PBMjlS9xpwX8gvcmCaFbFG/QyXqjZYzilieluphIVelJBdoi3kZMiopO?=
 =?us-ascii?Q?ndCjPAvv9WtRFWOaH4wPGNdcxm3uyUFgpgC6OwTnXh8F3FveGJwHQgeopKwA?=
 =?us-ascii?Q?T0g5OvnD6hB0C5twkazEtqxcan0Pynmt/W8J0JTkiFH4+TVg41KAEjWgNXtM?=
 =?us-ascii?Q?VrENk2SxxI5hBUeUlZnYo+aSlNd0zmulPldobHbbASCt4CKLVYTeC4FnyYs0?=
 =?us-ascii?Q?xEfUm7H7SYD+bSPtn6t/+/wXsS4py9krJe8MnB6ZdTnJ5jlpDlL+saYMceu1?=
 =?us-ascii?Q?cTE/g6JRSjxl6QEXze9LGwC77PcC27JZ+qHDzME/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vE7w4Ncj0eWx8rZieG3DEhfL/7/JQPb3FYv9Nl116jg7L5OXcofaufDshS95v/BEArtkObW0P99WzXEdMY2mIM72Po6LLaHVTOKweuMnEhf3BskJ2b4z41BHiIbaE2yIOaV1I7pfBsHSBHC228ThXN0WtWEzwu61wRC8C6xtHZ4LIg6NV4Ziypo41cyakhuQUQ684a/AvaBrVzmBVfjSGM6wHkNKcyxbREhCxe3FfQvUWLiJzj49zTWNZf7v/YKGW+mi/TtbrzcjOiAlmJtzCd/Sq7L/O1vWGjeAtP0fs3MaBjHo9SJA3UOJc9UPw7m2F4PU6Ns6WgPEeiNc+dFC6O80BcQp4oqh52IDp9sGZ945sX6AsQ/hdNsLWNyHKtENb7EQIauZb5N8gPpZORMDnAY58YE6J4TkFWo+aME4hLMks0scPQlYg0AtJeWoBwL1BHCCVx4o/YYjYu3wDZyArflbOb0A2VilMHIlJNr03Ky9ubi8fOYKqAYppH3CzA9f3vqCzs2oiHDU7Ygge/A68yvW3m5ov1RA+Hw1TTHkALlhfhEVhZVPp6VSK3nNCcCgv2fI1eQhLDdmBysZkKdG+n+nCOgYMOfLBdl8JD/jL/XYN4DDanm2iIVJgew/nwwLb0BQmpa20fQSZ2tCDkeTstebvQQIwmNuz6XqMqwJlbiLg9JOy8j7JuJU+JF9kxc3RT+9NQHMg8wkYasC5CU8EVsPzqVdGnOHAaP5/1v7vWTYB+EkI5I5YWQJUByZaLeGd+7x1Pt9vcLZQWoIeLcO6grl/zQ8XlqFQH11raRbpAEjCRFLerLrwk8QwX4LyDdvxcondxzjgiOjoyOAjvIW5YEnmf1ORGe+IdArjKyhZXCqltNyhPGthmzIMT6OSWcX
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8073.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a3efd-22b6-4ffc-b38f-08dba8a21834
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 15:10:34.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DP+Wju2PETT3MRNO5cl389iA/f43Sfe0QSV3on6OqfQG0d8BCqSb3xBRZUFCxjXvM/Ol2Yj62zbw3ZDGpif6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9083
X-Proofpoint-ORIG-GUID: txglVPSD5v3TIDTDp5Nu-ODJAKDVWJVm
X-Proofpoint-GUID: txglVPSD5v3TIDTDp5Nu-ODJAKDVWJVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=284
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for scmi binding to ACPI. Basically, SCMI based perf control.=
=20
We have ACPI based system, so I am looking for where I can describe (some w=
ay to describe doorbell and share memory in ACPI),=20
and then scmi perf can bind to it via some sort of transport (perhaps fastc=
hannels ? )

Regards,
Oza.
-----Original Message-----
From: Sudeep Holla <sudeep.holla@arm.com>=20
Sent: Tuesday, August 29, 2023 2:19 AM
To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
Cc: rafael@kernel.org; Sudeep Holla <sudeep.holla@arm.com>; linux-arm-kerne=
l@lists.infradead.org; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel=
.org
Subject: Re: ACPI binding with SCMI

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Fri, Aug 25, 2023 at 09:34:59PM +0000, Pawandeep Oza (QUIC) wrote:

[...]

>
> But I still fail to see how fastchannel doorbell and shared memory=20
> space could get bind to PCC space (type 3) ? I am on 6.3 kernel.

They simply don't bind to PCC, PCC can't be fast channel. What exactly are =
you looking for here ? If you provide more details on that, I can see if I =
can help or suggest or may be explore along with you if the solution doesn'=
t exists yet.

--
Regards,
Sudeep
