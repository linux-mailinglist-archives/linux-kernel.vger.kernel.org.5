Return-Path: <linux-kernel+bounces-67550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBCA856D55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092D61F2163C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE8139562;
	Thu, 15 Feb 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vzrg0/Qr";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BwWyh8OS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="On8LN9TP"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9835136995
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023967; cv=fail; b=oUkfgZpg5PZO8m17moHttslz7Wrpzmk/HlmVViPMhPPx2UIPhSQpV7kICfKsLmDNQFFHpyqmvytZCaQvt/16Ek0A7Jh09P62+pMg8OdDZ57Jb8hKYlH/l3h5c6C1OybIu0y2Ajk0gUbeNRXDsV7zs1OnRTT216cWkMyhvazGfeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023967; c=relaxed/simple;
	bh=K3/UBAA/mFD3MrHGTvvRzNYcEH9zeTiH0mG5ifkxpw4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s5Gv2o6ra8HtqYTQAVydy2UXigu7p4al3yzbKyMtZPA4eYbtrRa26JCCZezkiBzzr2GoBRqUbtzVQm5iU55shuLgeVZu62WPBX11Sc8FxRZBHuIH/803Q4vpjzo1qlnv9rc5PqpLnAjEZ635FhjACQYq/CW4L34RQdI5uKQelNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Vzrg0/Qr; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BwWyh8OS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=On8LN9TP reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FH1T7c006904
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:05:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=2GBA
	yHyhFv4Z4Wg2tfHghFR89zQrvACkwNzYfibFvxE=; b=Vzrg0/Qri1UcfsyXVCsz
	BuA46M11IlJ36CMqdRaZwxiMcNCQOzPibAx8MEsJ/GfTnqp7xro62T/4W8C42GH1
	3B/dKvWe+oTL2VqJE7qjHT1kV/KG+zrkeVVVbfdYeSACk7JZ+/IFz60vkxHCLAW3
	Vs0VY7jo4GFgKB+vbC7hBGML9T5QRc/GQbBhRaK8cmo90I/6WFxQuZ5AOeyzKIzB
	jSrEkhkaYVAn2fkrm+PVr8t7XEtjwA9u+1Y1ks8gC5cDiFKDEZcmNPiREZQG0WTM
	62oRLQhLn60RGsCPv85lJU8QabvkClKnVDESGdZzG+f46OV+Vveo+WdVVFZBlZAk
	4w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3w68ngw833-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708023954; bh=K3/UBAA/mFD3MrHGTvvRzNYcEH9zeTiH0mG5ifkxpw4=;
	h=From:To:CC:Subject:Date:From;
	b=BwWyh8OSPcvslLrO8gyVgkpv2hBz5QQs6SMEG7O127tLhB4y1n0fXfNEmLb+8xfse
	 22TVNPuY0hEWmbLLoQSODTInOT2BOG7OewDApNoeLlmjv4Pe068bhcoy2A+YG4JGb2
	 +R3Cytzkuz+xNt8/ZBgJdnjtY3EVYVkAkMxrZ1jbSPkZj4eTieBxNZFFfPHAOXe+Lg
	 Xyt2ESRD4y+oVjBz+Pz8CuufnPygR7KT47/e++RwsPAtVL1UYpzQZjVaUqyjGZ7H2E
	 5aPzQkO3B9RaGECITzfBS47JNLbCcEmWVWryYVq4W4XVtxps7BW1A2GS01wczVndSb
	 Y9gIWOHwCkR7w==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3308E400A2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:05:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DA219A006D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:05:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=On8LN9TP;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 98B9D40361
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7JUklVWkurUc98Z+TPLmOuV7gfRwbxyPEPb/FXJezkz9HYTVzOekKKI1CD/JUTPN1WWcNb+MdE8H9KwcrUhcQrNfnpbgdvA3BDxJREBydKTq2nEySOSwYEXo5GrXXUx3ELpAOweKLzQQ34/XSnvPD9KkseB9qJW0rSb5iVxQWzcU4TwuwaVKtr9LDxjSamT+X5o0k5TBGP/9QZCQv4XYn/mmCL2rm+P/MSisjSpXR+kn+bAppbM3JVoDtdAZXloE/tDmv6TARC0ZxGQTz2yYdJ0SrnwwJ6m9pQOSV1Meu7umKQyIYAvzaWm15xoNbqH/WNvTFUL+qWlM3vOyoW16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GBAyHyhFv4Z4Wg2tfHghFR89zQrvACkwNzYfibFvxE=;
 b=agyaYDbFihzwSk0rlLPb9qhiUZWX6dRHXBwpmHY3aemNwCqqsFVuKwjOMVntu/r/LOmn8rYtPdbz/lzDdeIoyRmxmtFoH5f0goORhgyIXPvme1LjXom/fpX0Wax0bhz4jxKTI77BsJg/+5pYX2cgF8wVHK6jDexbpcp9kjebW7tA+FbFL7e8QIM9Wp/14dUPTsxTbezfdzxVzz7/p3psiuKE012B7gbPvtczbj/8IBVYwTKpGA1aXAMgVftCgMsUVmuJTl0hvZ2pPvEpMTE9/1JvMyfyjzEwgfzOttQplosBlxq73EYgC+gEWSR405FpchrlhkSC0AMd/OglxiXQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GBAyHyhFv4Z4Wg2tfHghFR89zQrvACkwNzYfibFvxE=;
 b=On8LN9TPFqaECFZgSBUjXXpmWNCkb+ixB0Dd91cYVOwWuQzIXQ8TBRWZuS9frMFYijfyGgr7PFz0u3sqMIIZH4zXKl2QAOCCA2GImZKJocSq+fMnn7fJDknafi74Znx3DVco80Xf/xqsLjFH5Rdr6PDkmh9eH3Dg+1h/qKblsmc=
Received: from IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 19:05:50 +0000
Received: from IA1PR12MB7687.namprd12.prod.outlook.com
 ([fe80::b410:a6ac:5b7e:eddd]) by IA1PR12MB7687.namprd12.prod.outlook.com
 ([fe80::b410:a6ac:5b7e:eddd%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:05:49 +0000
X-SNPS-Relay: synopsys.com
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] Fix kernel panic and desc unbalance when multi-buffer used
Thread-Topic: [PATCH] Fix kernel panic and desc unbalance when multi-buffer
 used
Thread-Index: AdpgQOzioUkm/yFbTfuEdrhRvgV3gg==
Date: Thu, 15 Feb 2024 19:05:49 +0000
Message-ID: 
 <IA1PR12MB7687FC8D398F6A3E1776E48AB14D2@IA1PR12MB7687.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBpbnRvXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2EwNTI3M2MtY2MzNS0xMWVlLTg2NDktMjg2YjM1MDhjMGJkXGFtZS10ZXN0XDNhMDUyNzNkLWNjMzUtMTFlZS04NjQ5LTI4NmIzNTA4YzBiZGJvZHkudHh0IiBzej0iMjgzNCIgdD0iMTMzNTI0OTc1NDg0MzUyNzc0IiBoPSJmcGt6VDhyQzBMN2tER0pnc244NFVhbkFBV1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7687:EE_|DM3PR12MB9415:EE_
x-ms-office365-filtering-correlation-id: cc140026-4b37-48e3-10ad-08dc2e591f9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tKZnk9pe4C7+UD+fqSO/lhFAvZ3XO4yZ+ffwtkpyBTqyC3V6o12djiNALm/azUpp8qhIGbfUk09q5s6xwq0eAZ4EBRhHGPQNJRojRw00SOE2fXjvZMM1OnGGu4jsB7J5sNF8Y58BbYLtYERE07wSZAWCDun1rjcnpcMqxBtdRb+aqHNqRwUdSxsHPT1LuSkppgr7akiJ1WfmH6ox0sP1OVSmvu/S1zcIn6aLZURxeKNVsmpF0FlTHPUspRvy4XBqR79T+7j//p2mJ6bVmn96D3cCWZe8e48FOKLYC2bQc+V0AO3jTgX21XZ1qKwCVJ/TL+fCib19PMZcQfUDZ2IIOyhmSLMPCeV9bZCKsYIiignckvCJy0cEY4B7ljYPUnyTRKIQn5DnI2y9rf0Hkda80duF1hC4HHqnMzzuS2NpNc5yij4O+1AZwmbOS7wE1mMrlFQDhE6wBylg/OX3l+lu/0VZdgLB+Hp0eQZTmDDWbJMHcRbP4I75pWzTdzDndQ2YnicT+U3vilaNPhzEbuznRrzRUxP2+BC5CpVBFEAjpcOX09m9tODbE/8A4EnpPP9tt5CqH53B4HcQg+wUX+DUm4TSXE1RU4VuDHEE3LhvH399ynCZbDUykpa60mmchtxb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7687.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39850400004)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8676002)(5660300002)(8936002)(52536014)(2906002)(4326008)(66476007)(83380400001)(38100700002)(33656002)(26005)(86362001)(107886003)(122000001)(38070700009)(7696005)(66946007)(6506007)(66556008)(6916009)(54906003)(316002)(64756008)(76116006)(71200400001)(66446008)(478600001)(9686003)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U5H5sI0ZIJClAwj4otSeSzU91zvQ5fQCw0wceNiYWqwQmvNrh2Ve9vlvUQN7?=
 =?us-ascii?Q?3OVb2FafO0HCUC7fiLJcfB8ZdGpGP7df2gHzXkRwSmTKA6u6yzqYkSrbi3B7?=
 =?us-ascii?Q?iVhKTiR4nvG6/fGuoariWInJ5usGSglD3s//cZbQziY6VqmayVdm8DWYY3ts?=
 =?us-ascii?Q?y0mAhBOi5GQy4L2Tx8oEMWlLaCxw+Ya50vYDl48mi51kLJVgHBYTPAlPSK2C?=
 =?us-ascii?Q?fORM0QLBmvJu6E6OQds8gdGVXVHdsWtXsR0tgwt3pn1bak+aOj7wZJaDzKO3?=
 =?us-ascii?Q?fHLml/DHzmZDy8B8A+gyfBPknpKEoTRK+cpwjwuYOAGyasqzXE60+/VvCfxW?=
 =?us-ascii?Q?GcVO4IUg5m2Ddx7Wp4fV9IrpRtdjihlphFbQfWkcc23u9RorXZiunbME6dsF?=
 =?us-ascii?Q?eFgJo+mLc7htvO2ukEEo0JVXdBrOL7mHbJGTtTJMYsMivhWiwEjD5j1KD4I6?=
 =?us-ascii?Q?WZlnHN2Gmxoh8XV6Kj/P3e/dwqICQg2juJYd1WpggWPZRJsOJ8qRn/yywZKC?=
 =?us-ascii?Q?3uRgRN9L6qDoufqGZ6GZlsxDuwyJXCYOz8opSFEsorQgaMu9pDEGCs7nMj9k?=
 =?us-ascii?Q?lpvehgrV0gKBc/P9Vw1QR+QU/4jyztYZ8ISHqxEquDMgQIzd+y0GAMkHIGxe?=
 =?us-ascii?Q?Qnf3G7OO3izAKc/T8cwf0IAvgHGXKv31FiuReCoEN6JG7vGgiLR/aF3eGWP1?=
 =?us-ascii?Q?pch6mau31HEhzsDwSuGPrVAuPPTDif/6y9x9pdIe9VNeX4y7zK0FpKFNE6wH?=
 =?us-ascii?Q?4m7menCLT/FvZItd66uQQ0hU1iv2JAA/iQ5bYn22u3KTNSQ9A5p40Oz5zj6D?=
 =?us-ascii?Q?fIr6bcXPA2kk8VXqScK2FxsqjAtZjBvI3wodnzMnD3IBLtHCJhFR0sKMJAmq?=
 =?us-ascii?Q?sLZkvO5OI2zyKR3r3dn2FXv0ilhnt/sD8Jva+fx1cKFR3nVtkjpueehOLdXv?=
 =?us-ascii?Q?+AWfs6IIvFWdxzyq9PGDCmkYpwL4UlAqc2JUiVd69zjolwuZ0YN4Uo6wDK8V?=
 =?us-ascii?Q?aSvroTayQInDn+FSZRRlAggIzX1Ba9elHB1H6++8WYbzuVGxr4Ve5KbK9dTV?=
 =?us-ascii?Q?HeHra7f95GXuX42IkDABCHctjw6wnnzjBMdEn3J0dpijQKr6kuDq1Apbz72w?=
 =?us-ascii?Q?tTdeOoNPip1mbFFtTqaePuV/skXqoIh5UIvKZ9oq7+ovftRnMwaYW2M4otwk?=
 =?us-ascii?Q?1p0/kYZhgFD/JuvKdJpgD2eHykRAITVOZeyfJrRNFQO2wBwpad81sqvCwl2v?=
 =?us-ascii?Q?Z1N0CRVNI6f7q15RFk2mNew41RwqhLeZHEBAwWFYLtSqCcLFOAa9nkccXV2Q?=
 =?us-ascii?Q?SfIop8eDCx1mNtdTFdQjE2ti64sWVk76E/SJfDMWNmFGXKhNk0R4T+/jEZoF?=
 =?us-ascii?Q?qHSGbNfvlHQ/y0qZtZmjWspD8tdFPkIuNXXcs7n15aWcGl+wz4Dsh2iNTqtC?=
 =?us-ascii?Q?hWUqfKmQ8/Nm8H+31+i34gSJivcNQqPqFaaJFVWC5QyR+wZO8y7RwV36wpF2?=
 =?us-ascii?Q?XamfCMv5Vlrlsq9jen4binT/8lGxp/0BgAFLQabcpM2VvSFFktiQ7ELF3sfP?=
 =?us-ascii?Q?vbo8XW/ASnGa1rEyWYGh/pRcMNfn5cOD0Qae23JA?=
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
	bCBf0OR6/3wFUmf3G+2AyGZJYG6l9UlZlSLIKHVZu437g1n0xq19oVbPmW8bDCFuIjH+07fi9+qIFA9EnA6GkSddJtv1tw7nTjurXWjFTCQPxk5jBv33EL9uT4CC111UAGUt6NEKzZC50xf+XkrmPjPNwPhkE+m5XqfoXj8/6RrNM2QUGyWqiBmhjCBwD/bwjjty4P31mJK5zmM9MH1u/mUPVefUgNsUzILFiz+qoEKGKS+ZRlDNkZInX/0E0869HmFs9WCTRznL3x0PJXwNb3KCMo79PbMkxDsB1/i55n9NYaNn5tvMEBy3YPh64ibTuuw4wJ06HEmS2M17hlJxL8/gOItmd5kmsWE1ovLU+2Ehqy9e6pvtZvpE9MLTk2Q8XaTxFJOcawxT4osgaisgODRlojiHUgC7tcu1PM0OQ/aFg+fgxPqmW+y5ahDpq7Z/sdr8XzJ5VJcYnCZweyqYW6VBnU78PjePPfUScxZ7mecQC5Cc1O4oQJykUEcnbnqNeCh1HQZjnlEQ2hnvV34yDKUnrXFETjLro0JaZf1C+X5I3nek/lEFzSkaooAAskdbYFsvsjgznYKYntuhV43ObyAPY7jg4fApIsOTtAAiqCM+5RJz3l2jYA+KoouwKDi+/94748L7LOoRmiljYRJqzA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7687.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc140026-4b37-48e3-10ad-08dc2e591f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 19:05:49.7126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nTkH2pKbOUZ4KeNCINdKEA/7vik3saSeyOZl/QX9z1LND6HWEkZVuO8w8XUaYDh29S6PXI+wc4mfATy1mRELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
X-Proofpoint-ORIG-GUID: iS4JBu8tUd_-0VVnIB3skUAuJ_1nnHCY
X-Proofpoint-GUID: iS4JBu8tUd_-0VVnIB3skUAuJ_1nnHCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxlogscore=929 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150151

I have a use case where nr_buffers =3D 3 and in which each descriptor is co=
mposed=20
by 3 segments, resulting in the DMA channel descs_allocated to be 9.
Since axi_desc_put() handles the hw_desc considering the descs_allocated, t=
his
scenario would result in a kernel panic (hw_desc array will be overrun).

To fix this, the proposal is to add a new member to the axi_dma_desc struct=
ure,
where we keep the number of allocated hw_descs (axi_desc_alloc()) and use i=
t in
axi_desc_put() to handle the hw_desc array correctly.

Additionally I propose to remove the axi_chan_start_first_queued() call aft=
er completing
the transfer, since it was identified that unbalance can occur (started des=
criptors can
be interrupted and transfer ignored due to DMA channel not being enabled).=
=20

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 7 ++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/d=
w-axi-dmac/dw-axi-dmac-platform.c
index a86a81f..b39f37a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -302,6 +302,7 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 		kfree(desc);
 		return NULL;
 	}
+	desc->nr_hw_descs =3D num;
=20
 	return desc;
 }
@@ -328,7 +329,7 @@ static struct axi_dma_lli *axi_desc_get(struct axi_dma_=
chan *chan,
 static void axi_desc_put(struct axi_dma_desc *desc)
 {
 	struct axi_dma_chan *chan =3D desc->chan;
-	int count =3D atomic_read(&chan->descs_allocated);
+	int count =3D desc->nr_hw_descs;
 	struct axi_dma_hw_desc *hw_desc;
 	int descs_put;
=20
@@ -430,7 +431,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_ch=
an *chan,
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
 		dev_err(chan2dev(chan), "%s is non-idle!\n",
 			axi_chan_name(chan));
-
 		return;
 	}
=20
@@ -1139,9 +1139,6 @@ static void axi_chan_block_xfer_complete(struct axi_d=
ma_chan *chan)
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
-
-		/* Submit queued descriptors after processing the completed ones */
-		axi_chan_start_first_queued(chan);
 	}
=20
 out:
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dma=
c/dw-axi-dmac.h
index 454904d..ac571b4 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -104,6 +104,7 @@ struct axi_dma_desc {
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
+	u32				nr_hw_descs;
 };
=20
 struct axi_dma_chan_config {
--=20
1.8.3.1

