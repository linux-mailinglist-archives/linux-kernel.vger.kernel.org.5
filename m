Return-Path: <linux-kernel+bounces-167774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361628BAF00
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0741282A98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4837154C18;
	Fri,  3 May 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9l4IKch";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gxx0Ac6i"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D8153BF3;
	Fri,  3 May 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746508; cv=fail; b=fjdlGAveLl3IXIf1P/RZiaD6ILJJLJZdeqii5ebz41ndk1TYgnmc/bmV/mD1AN8F8TZHwGIlcLf2HO7x8ujszuDTXkx69TOFUBRLBL+RDbUrC3RBaaR5dVQYPE3KlsETOW7RtFi6qPR54PKefycP3COYhT4yvt16cgIEHkZRfQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746508; c=relaxed/simple;
	bh=fBhNESdjZa1PrSdzaC6GnwvBxXowMCBMeNsHN+6liDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrdfKvZ1HsXkueL0+oFfHcaceOqTDsze6OfGhTNi3mzLBbwba7QFzbBkgD8jGbPDBMwONdxQwhRtdAfJEHRLXupCtxQ/kMZc5TiP0avCNwbDh36xXOuuUV0boHPTLrVkyXbDNMGAooSvg7F85gyZsQy9pdGn4ck0SF/Nkp/Z1NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q9l4IKch; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gxx0Ac6i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443C2hEv001644;
	Fri, 3 May 2024 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=x/qjjRXqKamS/uqLFsSP2Q3u5oJEEDl0IZL/2Vd7WNE=;
 b=Q9l4IKchh2KSiM6DearQrSwfCw78p3OBnw3ijcouWkhq5/HWSxmTHdg+GLXwJNGvBg3P
 6/BV/LYcRQ0eaJsSZWb6tMjig49FA3A63M6EUEwMo/VUH8xDNReEixpE08QCegl8fy7w
 kD9T+YZcx6lqJQz0JMc5twhhBJ3wosRtCBwyg/9MQJa1VbYVEYo7R3Ez//2VwVysHrqI
 JZ9dSqhO6qUrsp0xZLpfBeW9DkLtXrX6ihgy3Vmguk+vmvwYjtKu7irsfyn7cyikPKdE
 +ajW64rdkStFA0uhayHxnJgsQqTHGy/MPwH4vD7w3Dn5/ffSfAQMW4al4SeeQunsZvXe tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf81j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 14:28:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443DRHCv020040;
	Fri, 3 May 2024 14:28:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbw68d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 14:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3jTlmqlSEThhM1y2zbnFYXJ1FWCaiMdYq73yQijP0ppbJL/lxlEup0jmMhuVnGYQ0JulAzvMJyjaMlXgx02I7ix+J2eORugOwRod+hN+qdCi3xYm9Qlozi1Rmkdltci0gicojG6X6vLz0Krqj2BJ/IZoqyfSSY0CkGtvhMzHkQ/+GXb/q/G05iMaIJ73HjNjFwDf54ynzTDJWHcb15O8O1K3uWJCDEkZo/BQZ/yvTwEwbY0w1ehbDhU7pUrZZcxymZuRjhb+fON2GbbsYhxmhewPHpRhxwVkOVLrhSpsu8MngUK5hWjtfqOB7G3ezn0277Rv39Q6j6ZY1YQslrklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/qjjRXqKamS/uqLFsSP2Q3u5oJEEDl0IZL/2Vd7WNE=;
 b=hvNyCfxQD1fJUkrRK6v7LIzwPsr1y78YFB4Z7Az2OwaUrIIIb8TJkOvB6J1vxYbGXv0j/VLUhPnjENCvZPTk21+vYFI5DBV1NUtlAY9Zq3cWBGBAgAeFuQrYuCvAjpTYu93d18p4VQ6FukRyrddtkfWaxGOoliqREAHPgLORezuzgyXnveahNE0d0YPmICadjrjcanFMMKzj8ogCGouPuEx/5AZrTkm0nkPYGGMZxX2UvX5CUltV9r3CJet0qBpEthvY0ktjik9jA7AldHapiBcL+9gejoNke9bwZXyBXrmNJ5zkjDcVpL0lq/fYp/+loE+TDJEdCavKt6CQ0a3Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/qjjRXqKamS/uqLFsSP2Q3u5oJEEDl0IZL/2Vd7WNE=;
 b=gxx0Ac6iFVNhw9htHvG3DeZGStO9Wu+eMiQjV3NNcLQcCtX1hVPU2uyuuX2c0147PZ4+/g9JRF4hYox29BsXu4fUBr3ZE/F/hp+AQIxPpKStbsU3iBSBcDgxUhhzl1zmVq5116Kzsz50/1FlByuSicPl5CRNPJgp7AvBiNNv41w=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by DM3PR10MB7970.namprd10.prod.outlook.com (2603:10b6:0:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 14:28:14 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::91e2:2c9d:3f30:39ab]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::91e2:2c9d:3f30:39ab%7]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 14:28:13 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>,
        "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu
	<rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH RFC] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Thread-Topic: [PATCH RFC] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Thread-Index: AQHamweIx8KdUY9mQ0GzMC27Mq44X7GC81qAgAKganA=
Date: Fri, 3 May 2024 14:28:13 +0000
Message-ID: 
 <SA1PR10MB644567B49D44BA641CF63E828C1F2@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240430140010.5005-1-praveen.kannoju@oracle.com>
 <20240501151251.2eccb4d0@kernel.org>
In-Reply-To: <20240501151251.2eccb4d0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|DM3PR10MB7970:EE_
x-ms-office365-filtering-correlation-id: 5ee38427-1571-4991-bd77-08dc6b7d4403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?CvzU5j6IrjfR50F5X3RcDcou/3XjeGm8jlxwY+7lgaWmDa4qo6JZ/KsJgit1?=
 =?us-ascii?Q?26uIrCV6ULR+MnSViTcdUMgtgKDrbUdBq6YbrtbpEAZmQ9q9pfZlapFF3xhg?=
 =?us-ascii?Q?1aYSOEmwZu36YZa++4Ne0yBFDGcT6LfiA1u9EKmSUN0D7Btuf3UVn8UDOI/n?=
 =?us-ascii?Q?KNw7XKWALonvxf8u/ejqcGnrC/gNkPWLk6Cm/HKF9NAjxvrjL2ncnvLe/Pgr?=
 =?us-ascii?Q?4BtOmbguS8lM2NRAqyhBdeYNQ0RRgW9rFmgGWj8JF3uNjRORr28aGGD+Lo8E?=
 =?us-ascii?Q?xSc7Fk2bgPdUCajfsWOpV/kvXvoCZf8pXD22hzxumRXjZqNyYfoepSfWsBXV?=
 =?us-ascii?Q?gkS0xm2z+oE0YI3tu8C1Y7mHInIvVF3cn2DfcAvCj02K8vCjXc9hGfk6XGvf?=
 =?us-ascii?Q?b5bLy6jZeOrwezAhDk2k/wUxBO0UnM+wP3xouFZlkHNNtDwYtkuwSivv8aL+?=
 =?us-ascii?Q?rc/5XpcMKmLycRveLrDjbnRNIcCxk/tnfic+0dmrP7yv3MOxlplEVWKC/AtT?=
 =?us-ascii?Q?6zUWfhF9D9ww2mGIiLkj/UoUWA4ulCTPkQJt8etbhvZyG9yFRL2tesCs0LHS?=
 =?us-ascii?Q?r3k0XKzw4aXJW5HRzq84FKl2OTe1XVqqTGYPFTucWeN6AjTINKmO4qeNLxQd?=
 =?us-ascii?Q?fNjQL09ZQ0D0SS4WZ4GMwmHIFo2oUBxQ/M/i7Te7nr1gfLI2wSQH7Ccap4wn?=
 =?us-ascii?Q?snHvKvWzzD/cFoKi17mXTg95iL1xrNlU5ukG2v5OLRgcpNaqXJJNj/VVIgar?=
 =?us-ascii?Q?6bzaB72L6BYiWXvhwhDr4hcf742Dls0lX8vew9tHM1bxN/jI8IyKOLl9q1vW?=
 =?us-ascii?Q?BxKZQJgb8r5e5NElN/3I9OY3fi1kiR7kHZ2k6PdxoO6i421P9nsVCZsGXHc9?=
 =?us-ascii?Q?yifeK5u9t0iihD50e1O+lyZG/tNt7JNknPaX/XW1UYJCc/xNbAqC38s7CNRf?=
 =?us-ascii?Q?hZyvd9O/UB69mHxu7GDWZZ+OnsyCGpz6/rPIODXhzaQh8ZOmfWLQJykL9+aU?=
 =?us-ascii?Q?+qcOkOQulCc5a8Bj/H7CWMd7wbtL8QLeDtPcL6/nlXXn5ZOw/uR790XU22TG?=
 =?us-ascii?Q?zhOdKb7NHjVXkJhw/ykOEJIsbQo46I+9zvcZvNwO7qGXKdcly80BMUdzDCcu?=
 =?us-ascii?Q?42MPv6GMHNGgoUBUuoBewdTEyz8vMAezJyjZ3CAOM0NScJaGqK8Ikk6ySH07?=
 =?us-ascii?Q?qb6fDY15Dk7iaXfBxqGi0KuKFVRisnqnHTCtl/4V9zrlSYzGhKvlX5rkcbLm?=
 =?us-ascii?Q?Jw3+xlcd4ux71J3OHSR6QGV0kYU65fFwUjzRcrsgEq5tO65CSSJQxcJ0yiwU?=
 =?us-ascii?Q?Ui2F3XAiCqqKZGmKHmU3AC8M3VyfBnnH/hjZQaAbFfGWJg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lJnndFG555XJGtS8Ck/cW1TVlK2woB+OiurM8LCkX7TvpzPPlzhEXZNWdZZa?=
 =?us-ascii?Q?ltiuj8O9zO3uPUo9iK49p/B2/cTehKKIO4sLawMwiyCMshL6a1vjgV9Y/mcK?=
 =?us-ascii?Q?EH5aeEiHIdrKNHhhmiWGWBNJeLXwPa6/BIY7KSCdUbyYPJM5chAYQ5P1CY8m?=
 =?us-ascii?Q?/hj3UZqFalrn5nWaZ9M6X96y8kU9cukUGbW/bZenwdfmZn7kmCZhgCa/6qBv?=
 =?us-ascii?Q?KbMw32dRqntNi900UEHFgJIO8JHCt1Ins+gbzzeZN5IgZcaf4rucNOh/m1Lv?=
 =?us-ascii?Q?dl6dO837WoS/2/U/bMPzF14WHL0j6HOglmtu2EpfGVHFYiHDHp6kyHlH9Ill?=
 =?us-ascii?Q?aN8ZZejOj63OIhNrz0Xkf/GjMrU4rNY9PZ15Id8vjND7A5PCJduC8Enr/6+N?=
 =?us-ascii?Q?eqVV6DSUqHHS8P7/5NEtT3vYRWDcOXytkUKDWIv8kHG3G73oT8bd4ApJpom/?=
 =?us-ascii?Q?/A4zVN021hcyOKtA6yCyHdgW6HvHBW7Qaks+tJb+oEKULx6pBSjZ6JSkx4mw?=
 =?us-ascii?Q?nMtlyiOSm4nE1E2nQGDErA0ydcnpWWBhLtcVf+fRlX6FWyRnU6icQkr2tUJI?=
 =?us-ascii?Q?x4uYB+S+PPqTvyPGoloOHBKjqA5Zvz0hdZTqimmWgt7r7AxA3BK5K+rMaHT4?=
 =?us-ascii?Q?Bnu0ZMkM3qJcrLOq7huloFrPfVboxc/45Vblau3875e/7lVpqmcWPVI5lMz6?=
 =?us-ascii?Q?+dZ7Y9d2lNXXH2FRRuoKe2G2ROF7mambTa4YvUaUYqU3atLp3HEvHvv3WHrN?=
 =?us-ascii?Q?lqSmmp4JqOqFmSYej3ld771iqCaEQ0GFo2YSPUk8y4t2XqpxujFui8cy0WCw?=
 =?us-ascii?Q?b+nJ2jJ9Q9QwMlN3qXGNUqeJsvTMtuFNItrjrcIRB8K3N5d++DkeFmT++m9b?=
 =?us-ascii?Q?hi/dteF1j7GOFgOSxFIYI0I+2gz8UjT6M3tk5uWa7nVqFUlHnjU0su9LhDCN?=
 =?us-ascii?Q?Xew0Tn93gJsGZ3JkITlK62m82VachrJ91vXb4o2/S+3t50tLt4I+gQtS/5TF?=
 =?us-ascii?Q?FLvdO3qcY9moQXfKbQ88X+xSUFVajWbCkQMLEopgmYWt8xIzIYbw8zKFxAif?=
 =?us-ascii?Q?TAX7wjOzziChKbyWMiQGAWhjNnDxYJ/FnVuROyUTAKy0u0eF8ypcc0BlqRwN?=
 =?us-ascii?Q?/8xUVIJ6SYb7ep/yyFV28LM/ogRccI+ejd8MRP0cnuanqvuxu6ib1Voy3m+j?=
 =?us-ascii?Q?PsFISuCmCAbC6o8GBM2DDM4iSQwWrsSR26raTDv20wExc5Q+hgz9PRfaDgrl?=
 =?us-ascii?Q?Rgt/a/VGoHU7zPF+uusrAHAdV0+i02QcbS53U3qVVFWiMVGz4QkfQv3ZY5Hh?=
 =?us-ascii?Q?MYyadqN9GJRMfFgINowjBGUiCjZR3Kp2z0GRGw+iCwL5QRlmXyd9GwhXeD6Z?=
 =?us-ascii?Q?NbpuncULKfbhzh3RLVynunpjmAdSBBmjvyrZcja1AhRJhw0fRDQws3VSQd8B?=
 =?us-ascii?Q?67sUzpqCH5pftsz7/35GkoBiz8SLAGg2xS9FyIRFbVE2yTLD8OJS997+xV+f?=
 =?us-ascii?Q?AumWa+5iLL+cZHIEMclAukG190d5WVo3/mAC/PO12emN6ut/xe0knrF03P/V?=
 =?us-ascii?Q?jMIqm0/tJWDsojFiDDqyhTKarznv6sM4WgcalHkQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lZMTQBtHP6kpHjKQY73WIkE9I8Lhkt7pl9m2hUiA4iKufNHfcTMIbKybNIoikS7CF2MewuB86Ra4Feh5Kk5cdB11bI1APLgQc1vvhWifTlmbBq4+mpdk5A8lQL9NC7ukhLcjBw4w0hqm8Ah/p0nm4PSlOsZbunzelXzxSrX7MgNsh8vH9DL+3fzwdnpCs6zWp474Rby2kPTd6+ZO+IseX5PqQ2qM2oGquecv/Xh5xljgfbJYhYtJxgVo0qyOqFQBSm1d8PyfMQ3crjyrj83rMY+5jPE7vD4ZkHS59x3D96ARZlyUD5mlW1Lypxfs/GfvlgRpbZkp1P6I9D5ISKX2zx2pMY5QoCaZbdMNVA9EO7NFXKHKuv0+bdVOCoVmfG6BZobEi7iIbCm3ih1UdbntZQB31fykpi4Bpz1WDXfUs2QZ3ZJed0nnq4OsZNgT5o4nuTtiIRvkkoaD7W4Q6x6+ACjBUMLc333UyHekiEeSfi+Zu8AVVbvWZqA6MwwNUzeK3sAPiykx02VZ74utgnUbhbS/zCEE+WdrdQttbOA8r54REzTWQ4K4TA2eJUQLKZDStPRl5/fYpDxOCC4FOWMRb6pOSs1e+WtqosUDzZQkO8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee38427-1571-4991-bd77-08dc6b7d4403
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 14:28:13.5464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1MIaq7mggETkuJiACEdgRcqO2QFGPYlQxJqq1AOJ/epKiYnd+w0LNY4XMkwcnsPVI50yDUvBw092zKLB6R5ZpRgF6hspPhsn+H7ai7szLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030103
X-Proofpoint-ORIG-GUID: WJKszcr8RJg5s1diYNjAkc7jEaWJB6ux
X-Proofpoint-GUID: WJKszcr8RJg5s1diYNjAkc7jEaWJB6ux

Hi Jakub,
Thank you very much for the review and positive feedback.
We've incorporated your review comments except, using "continue" instead of=
 adding another indentation level. =20
Request you to elaborate your comment on it.

-
Praveen.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 02 May 2024 03:43 AM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: jhs@mojatatu.com; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@d=
avemloft.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivaramasubram=
aniom@oracle.com>; Rama Nichanamatlu
> <rama.nichanamatlu@oracle.com>; Manjunath Patil <manjunath.b.patil@oracle=
com>
> Subject: Re: [PATCH RFC] net/sched: adjust device watchdog timer to detec=
t stopped queue at right time
>=20
> On Tue, 30 Apr 2024 19:30:10 +0530 Praveen Kumar Kannoju wrote:
> > Applications are sensitive to long network latency, particularly
> > heartbeat monitoring ones. Longer the tx timeout recovery higher the
> > risk with such applications on a production machines. This patch
> > remedies, yet honoring device set tx timeout.
> >
> > Modify watchdog next timeout to be shorter than the device specified.
> > Compute the next timeout be equal to device watchdog timeout less the
> > how long ago queue stop had been done. At next watchdog timeout tx
> > timeout handler is called into if still in stopped state. Either
> > called or not called, restore the watchdog timeout back to device speci=
fied.
>=20
> Idea makes sense, some comments on the code below.
>=20
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c index
> > 4a2c763e2d11..64e31f8b4ac1 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -506,18 +506,25 @@ static void dev_watchdog(struct timer_list *t)
> >  			unsigned int timedout_ms =3D 0;
> >  			unsigned int i;
> >  			unsigned long trans_start;
> > +			unsigned long next_check =3D 0;
> > +			unsigned long current_jiffies;
> >
> >  			for (i =3D 0; i < dev->num_tx_queues; i++) {
> >  				struct netdev_queue *txq;
> > +				current_jiffies =3D jiffies;
>=20
> Not sure why you save current jiffies.
>=20
> >  				txq =3D netdev_get_tx_queue(dev, i);
> >  				trans_start =3D READ_ONCE(txq->trans_start);
> > -				if (netif_xmit_stopped(txq) &&
> > -				    time_after(jiffies, (trans_start +
> > -							 dev->watchdog_timeo))) {
> > -					timedout_ms =3D jiffies_to_msecs(jiffies - trans_start);
> > -					atomic_long_inc(&txq->trans_timeout);
> > -					break;
> > +				if (netif_xmit_stopped(txq)) {
>=20
> please use continue instead of adding another indentation level

We need to take decision on whether to break out of loop or modify "oldest_=
start" only when
Queue is stopped. Hence one more level of indentation is needed. Can you pl=
ease elaborate
on using "continue" in existing condition instead of adding a new indentati=
on level.

>=20
> > +					if (time_after(current_jiffies, (trans_start +
>=20
> wrap at 80 characters
>=20
> > +								   dev->watchdog_timeo))) {
> > +						timedout_ms =3D jiffies_to_msecs(current_jiffies -
> > +										trans_start);
> > +						atomic_long_inc(&txq->trans_timeout);
> > +						break;
> > +					}
> > +					next_check =3D trans_start + dev->watchdog_timeo -
> > +									current_jiffies;
>=20
> this will give us "next_check" for last queue. Let's instead find the old=
est trans_start in the loop. Do:
>=20
> 		unsigned long oldest_start =3D jiffies;
>=20
> then in the loop:
>=20
> 		oldest_start =3D min(...)
>=20
> >  				}
> >  			}
> >
> > @@ -530,9 +537,11 @@ static void dev_watchdog(struct timer_list *t)
> >  				dev->netdev_ops->ndo_tx_timeout(dev, i);
> >  				netif_unfreeze_queues(dev);
> >  			}
> > +			if (!next_check)
> > +				next_check =3D dev->watchdog_timeo;
> >  			if (!mod_timer(&dev->watchdog_timer,
> >  				       round_jiffies(jiffies +
> > -						     dev->watchdog_timeo)))
> > +						     next_check)))
>=20
> then here you just need to swap jiffies for oldest_start
>=20
> >  				release =3D false;
> >  		}
> >  	}


