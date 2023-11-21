Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09C07F2902
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjKUJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjKUJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:32:21 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6E91;
        Tue, 21 Nov 2023 01:32:16 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL8QdsY004169;
        Tue, 21 Nov 2023 01:31:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=EvIbkTc7/SJovsziSyShxIi5ndt7WBRvmn8fo+ZQXx4=;
 b=JYhFGlZ20mdwWe3T9vy5NqukHuW+L9RAANqx+gmKrpwK9HizLaAjxAvSPju+UE5Ox38X
 3wpv0hBTAMR8N5vKuCouXY1uUG+eb8S37Dm+8cCHf+BJ50rgdMe5gtZKKazOWkxlcsEw
 77tJP1kVsTZV4LoudBk1MFar7UgXTuVc2ZAz3vQmNXeRYzyCWNm9dIX2tZX3bkvfHPZB
 MIF++oKXRKQ5DI3e80iVyMW0dHDD9pgK2nUFUDz2gmPqLqA01JF8iFLVT+OS3Kp0lDm3
 M6iMXgIhjH/ZJaoOvP8ZMk/BsVeY5OBvPqVdNobblT21Mh6VtSc2Hx0X8u2wKi9iOhmn Iw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ugs1s8a56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 01:31:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700559104; bh=HyCVmIHVayOhuTMpouKEHPoECpQ2fKgKhch/wnwb8w4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iQ8E7Q8ZECdG73QSh8QjZ4C6jMBHrOD6WmA6tOuoWN5I4Q/gKkZ37UUwSihGRPizU
         zKlhUDDHxSYc6AnV37vb7YtefrzPObkJ3eP+uxEDlg/tt709D56xIm5XaZXwe8SCJO
         cHoaKV0a5/hP3/DXVQVZOdfkZipO0L6bIqHkyTZz6QSyeL0ex63qa/tNe7F70NdpEU
         CTSmeSFMDH/JtyBOvh0MsEQTUcK+XcewSB/YoUzfxyhNaYnf888pVjKyduzwPwpVvI
         2nmWNnTjHiW+k9nZEAeKiR9eWtIixO8wOwdALm5KaDlf/YO3aMpAKegRYokV423pWc
         laIY98tJ4rxDQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2DF7740087;
        Tue, 21 Nov 2023 09:31:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E14FAA005C;
        Tue, 21 Nov 2023 09:31:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gQ4Jjm5f;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 85D0340585;
        Tue, 21 Nov 2023 09:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYPTGI2/aFmyR7V157zsu0smvhFZf5c2EqtB0XNd7nYfaCjOLsZvVW1CYkYDlyG94/ONtNY/2qL6w4z3f6s+4Wh60StgyCc+f0R5x7IfSKTETYFYK+t+IF6xxzST+yUDNDpy5WSSiaN/j8UigOu9Wj4RqzA7KVX0KVfOTZTFlR1IIAtvjAvEf4VSbQCB+mqz/vJ24CeYnuf+w4J4lBWpPBSx2ITeAzJareS9gfkZnOq9iy/jfN3DAeymxGus2MyKJDh+FOtBpJk4WeWWYMEhyjcCOnLR54UDfjZR6Z6DmtOP7iHyKb4qPjVD8ovUK51JtT58OiASzH455uG942DvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvIbkTc7/SJovsziSyShxIi5ndt7WBRvmn8fo+ZQXx4=;
 b=SEQm9WoMQ1819WdPDf9DWV3X4u5LxKfNPvLmSbP8GPAKq3sr8ciNaiY7AS/SThe02hWKUkZpzjUTAUbLCEgopnVe8/3vJnROqTpl46dLZd93fgUNsLwCY6+Y9oMEOF8lSxg/Rxhr5mIRAt3lC5s0vFLkEp/xfbidCmC5m0WLEznO1PD6lTLf1cd3tOXkEsoHMvTKM+8FklyCSbzPTPo66T/AlqTyICV/4mOtGhnpBunL3fW7twWJa58F9jDPnAtG1/m7a42XmTYuna+z2yfoyJ8zTAE9yXn55PbEVrCBRYLHKwqu7y6AgB0II2q/KI68/Qo99mew3yU2u7KsocnC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvIbkTc7/SJovsziSyShxIi5ndt7WBRvmn8fo+ZQXx4=;
 b=gQ4Jjm5f+Ns8mFnUCMcOlvY5/zkhRSk6oQX3pfahODMUP+GtGivI19OkqcBpz6WQMB4QLYtVyUXIovlSdwmUHMkizSfdlmsxsd6EdlgTCyg31dRt+qIhQGMy4lfukAkGrI7JRI0vgNVum53CQ54+VxOjgk3CWu3rEddyEmXG7TM=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Tue, 21 Nov 2023 09:31:32 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 09:31:31 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>
Subject: RE: [PATCH] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH] net: stmmac: fix FPE events losing
Thread-Index: AdoW3Xfb3QHiuCaqTA2ROZ4444S4MgAFJ5GAADdg94AAAqmPIAEgkfEQ
Date:   Tue, 21 Nov 2023 09:31:31 +0000
Message-ID: <CY5PR12MB637235F27E5114CFB4DE1AD3BFBBA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
 <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
 <CY5PR12MB63727BAD92930CB04DE4DB52BFB1A@CY5PR12MB6372.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63727BAD92930CB04DE4DB52BFB1A@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|CH0PR12MB5281:EE_
x-ms-office365-filtering-correlation-id: 85612a84-8cda-4ae5-feaa-08dbea74a56c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64Owp6jE5Y95/576SDKqRCgYPC0M09Noj8+DWTSFe4lxcUbFLz/7sh29QHODtnpEFMg280C9SyIg9+WjFE98LYoON4V1ddalJpJ/xoTCuiJ0dV2E8lEyNSBxSverLoCJFN1aT/R3xzCpVfJhVO/UGuaBs5KwXck+xbdC22aa/rYdL6JyidG0CAIQTY8EH++2VIz2qBEuZXkhtEuUw7nDU9YdDueHIpNZLxTK7zdCBAYihyD5Z0FiTwqQmbG1xMx0PSeCxslDVa7vdoojXZiywQ0RgDWMp1RyWXVuVcaZXOVkzLnDf5vKlcQ5VKsaiis+eATLaRrYb+qgqRA4xxqM51wm8W/yvAV8IX/Zud6dqnn0pOpHyRWIS+BD9KhcrCLsxSPNQTT4t3RcsWTnwYG9f/q7fNqE14rzLh+0YZ35au1NcXMqIj6olx/dwibLXAFmoaY0xe2eJzSlTX7nMjnNXD4mlb9to1+Ows0S6kiAgZnRKPz1Tds8JJSLbeN98ndj9Vj7K5hs1zWvM5DWG87TUxmHTUDr75IUuAV3i3qK3bmfJXl25b0+HxN3V9+edIuRooG2WqXVDQ6haBZEkCVbULj+wlW9t7MfGYlkVElPhpM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(66446008)(66946007)(110136005)(76116006)(64756008)(54906003)(316002)(53546011)(9686003)(71200400001)(6506007)(7696005)(26005)(107886003)(478600001)(38070700009)(966005)(38100700002)(122000001)(83380400001)(33656002)(86362001)(55016003)(5660300002)(7416002)(2906002)(8676002)(4326008)(8936002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wW3RBzaNtQbo1FmsD3N3Le7s5FjJwFpaE/lZb4bcdZw7nrtPR3DJuVK5bnD1?=
 =?us-ascii?Q?L7lRbeuAA+vdXi8hE8c9+Ri236QJx7pY3L1y1ekuyJycJt7tM7SYxCVUn1zw?=
 =?us-ascii?Q?C0KuvB00MU3lJjgt39t+b3w1bt4wP3msDmaB73KfsfjAL3Z2KyzH5wDtVRYe?=
 =?us-ascii?Q?PKjkvjn5tFVmd787+9xOfPoUTFz1jagOt8d8EkHRoaxWlSGc+AjlVg0cWrfa?=
 =?us-ascii?Q?tmN22c5NJz/hAV1QZisdcpXI7D8Jp5XTltQeovZy79BdMBONN28aoQ2cv1gx?=
 =?us-ascii?Q?Jkk9vi1EFXKmQ6UDkVUNt5gdYo1ZaMonEsUrA+pKIOPVD0j3oUwk+QgSwK1N?=
 =?us-ascii?Q?BZbzeqy4S1XklI5bXc1RDtCyA2nqooXq0VPmxFwVpZHC4RC37kHMD9xraCqS?=
 =?us-ascii?Q?DAwYPCYeQFIFnSH8XtqxQspBj8v+TVeShL13QGikKTcebe6YqJZKyigc2/ya?=
 =?us-ascii?Q?eLVi/dJUi0yXcrhYAJ0lkWZXAiz23WwkF+jz7sNilTd9l+xMlb6Mp6NMo5KL?=
 =?us-ascii?Q?NWzDPF8jXS9P3pCor3KWWiyJTsACAbVeTEKS5EgPZF4chUAw0XrbfAHZ8Rwb?=
 =?us-ascii?Q?IXyhlocvqaEHhaQQKi657UE96zEPT9gw09zb1s0l2d8ZqWw0Czh42IuTVIr3?=
 =?us-ascii?Q?IkHXUAByJac+O83NxBwIPOI+VOOINtw8rbGi1WxL78rv3HwL/rpFKvHsl6Yr?=
 =?us-ascii?Q?wLh4OogJtrl+SdcTAyJGKLY3hYBYnyf6jnrzza4PGHBILBSF+nDUlfmQQuhy?=
 =?us-ascii?Q?SJJpz611DBuCoOpzakWQ2oU0/gZaJkL4M5VdaKsImCrDc0b3qXWdxBMUnhWP?=
 =?us-ascii?Q?4F0Z4PIKX6tnE0BeOzkUclmcqEGxuXU7toeRq1Lg/eTEwxa7w7tgtPcn+Sj8?=
 =?us-ascii?Q?U3ypU1aCVrvFpflG+tBV+D8c0El8AbRk5JhRDhHH0AfmksY6g7hC9ys9ErhD?=
 =?us-ascii?Q?SG8ZRoXTzuaH4xfSnBbjVGT7RUnRa4V74y1f8EX7Zdwoj1hVetnk4oMzWHrk?=
 =?us-ascii?Q?DKDnX/O5dwwjNC0SqRkHCS2I5Fd1qDRrB5Y1jGPUK0XTgHxAXwt+Hfa9hKqj?=
 =?us-ascii?Q?7fIfzbyVR/PCWDHIWtl19pqCVdZWOCQTBow/BY52DdwgYz/kyytprj+Es67W?=
 =?us-ascii?Q?nOXCpUoenPDHjFH8zsB5FbOrAhPv0RlxcWXEHNSfi2bUE1EDZy5Ck6D+zChV?=
 =?us-ascii?Q?MZ8jEBZkv/1yG9gN07vfIb6DVs9QRlLFU2eqt33314uPsh2zoWPSmUOJETFL?=
 =?us-ascii?Q?oDq4NS7Sk1H5VSfZkER8yV3UN3Tmw/gLgo3xtWAFiaMhwqHLXLMXlGYAqChg?=
 =?us-ascii?Q?057hc1vuHrZOgmBHpyFsqwVkoOUQuaTio4hCaD4LK5sQe3Kwr4pIFtlb+7Wn?=
 =?us-ascii?Q?uc1WEHyCeqOP8kAYSqTf6Pd828D0v0bd70aJYJJCtc41orh1Pr6+hbV9ZbLg?=
 =?us-ascii?Q?Q1Ua11cSTHjh7DelDOafQnWuiVoM1YJXmEEafQahoVhJJLjncsP5n8PeHDzd?=
 =?us-ascii?Q?g6HTl6zOVj0EPR8F7JB612mO9aDteAxtbTYBCVeE+JpBROyEc7PEuB1UySoY?=
 =?us-ascii?Q?YTU8jQB5cWOA+cm+OUQtyFWtoNakRQa2GuyK/qFC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sp3qw8hEE4xybq9Hlraev7E/hT7aQTKU1/rMh9tD+SFgHX++zubEWtceo374?=
 =?us-ascii?Q?hH0mS0Yjppv0yBdx1oZ/X42RM9eAivQY+mGCYNTIvJK49l3ReKK3KHEkoqgL?=
 =?us-ascii?Q?QYvAXoLbzd7Cr8ulWQlSkwTOauCSNFeuU9hFdFjkVy0gTgDVYxSrmaDeTH/7?=
 =?us-ascii?Q?sGpEbryj0KzrFg/he3Y0kpRE4s1kBOaRwN+j8sXmUUC6DAyYAFDKandjw4bk?=
 =?us-ascii?Q?grGh26W1AK42CUfjapQMpkG4WiDvSlvH107R/jU9dmfoSubu4sqs+TtrDA/c?=
 =?us-ascii?Q?dXPA1oVLYb+TNdgt1hWONnZksZzYj1RZ9khcRgEjVGx39M+6f4Knc/+BvOj3?=
 =?us-ascii?Q?3BEYSQIhrUmIScedgov7ETctpyBlK9+u/52E7Es+U7IF/BRhNFOQNjwFwOUo?=
 =?us-ascii?Q?ojXnkjF8Gl05O/D3OYlpcxbYwsQ8uq7Yb5AwTqqVNCBd2vCUCp+K/2w7zud/?=
 =?us-ascii?Q?zFxob3LfyKqAogwFz+BaqSahYbZWfIXgA+cRT9Y/+8fscM4FacUUFmOavCUF?=
 =?us-ascii?Q?aIiNPHZnCny+OzFPxKAYcEuezRa7zPBIs+cgRLZXOO9wj9jiGs+QRkZznwLU?=
 =?us-ascii?Q?6y5qxkO5K4dKDMPpSUbO9qE0I5XnCu7/aMyCmBznf/No3/hmp1PNzyiz+oR7?=
 =?us-ascii?Q?ZAgp8pqXkpttqHfhN1uFExrlLGuuvKfp+VuBfC+yJlP0+BtCZzv3Obx4Dv91?=
 =?us-ascii?Q?4Scz1Zy0v9jKlZ4201CKB11/QIW2ZtHdZQ6iWQ4MVOCO1TUnfW1uVZJMAs1F?=
 =?us-ascii?Q?ebqXrLtGz8qFHFLUNp56QXQpbIFhvHoSr7k1K2QfkF8QggvRTFGPFDkNlx5c?=
 =?us-ascii?Q?pS/NKwqqfiwx5AySxXFgnJz24ahSlJN9dvMgiriUv2LDwM6JO9iF5n71oOyg?=
 =?us-ascii?Q?9UV98plseVbi4oWXsS00EWv3WyCUeTM588GB9AFH77eZviiL+eIauzp7OTt2?=
 =?us-ascii?Q?gKGe31YTpYORLok6CPNPaxmhuEEHss7aecI0jmiywFW2YlrOv3L3kXXdkiDM?=
 =?us-ascii?Q?QalbSpjijvb8mi9pup8wVufszTPCb65m6SXI1w4pSICrGMtiiGDfePlzF8ge?=
 =?us-ascii?Q?8fs1T9LQReozXvzdvARUujACOoaa72bLA9Lw2InPXeVw8Z3S+veBLj8esjG5?=
 =?us-ascii?Q?iDVVafoTW5gYXPK3v1xdc6d1fFVDqTtNS9FbzRMedIw2/a/i87HIgP+S7WcI?=
 =?us-ascii?Q?vkUBru3nsGn3uEPe?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85612a84-8cda-4ae5-feaa-08dbea74a56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 09:31:31.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMk4F2J6gyrFX3GOj2iRmBmwi/q1zbb9ln3MfR8Is2dbdIZU2eIqDLcgtb7DNxlefr52XEL4JR0C4hnr6MdCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Proofpoint-ORIG-GUID: cSh1t1yO0IQdrarOmRt4FZR1vnsqIXIQ
X-Proofpoint-GUID: cSh1t1yO0IQdrarOmRt4FZR1vnsqIXIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jianheng Zhang
> Sent: Thursday, November 16, 2023 12:01 AM
> To: Russell King <linux@armlinux.org.uk>; Serge Semin <fancer.lancer@gmai=
l.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@=
synopsys.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>; Ong Boo=
n Leong
> <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; Mohamm=
ad Athari Bin Ismail
> <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradea=
d.org;
> linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] net: stmmac: fix FPE events losing
>=20
>=20
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > Sent: Wednesday, November 15, 2023 10:26 PM
> > To: Serge Semin <fancer.lancer@gmail.com>
> > Cc: Jianheng Zhang <jianheng@synopsys.com>; Alexandre Torgue <alexandre=
.torgue@foss.st.com>;
> Jose
> > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Er=
ic Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>;
> > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@i=
ntel.com>; Ong Boon
> > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>=
; Mohammad Athari
> Bin
> > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infrad=
ead.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> >
> > On Tue, Nov 14, 2023 at 02:59:57PM +0300, Serge Semin wrote:
> > > On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> > > > The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE st=
atus
> > > > bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bi=
ts to
> > > > avoid unexpected access of MAC_FPE_CTRL_STS status bits that can re=
duce
> > > > the FPE handshake retries.
> > > >
> > > > The bit[19:17] of register MAC_FPE_CTRL_STS are status register bit=
s.
> > > > Those bits are clear on read (or write of 1 when RCWE bit in
> > > > MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> > > > MAC_FPE_CTRL_STS control bits makes side effects that clear the sta=
tus
> > > > bits. Then the stmmac interrupt handler missing FPE event status an=
d
> > > > leads to FPE handshake failure and retries.
> > > >
> > > > The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or reser=
ved
> > > > that have no access side effects, so can use 8-bit access for
> > > > MAC_FPE_CTRL_STS control bits.
> > > >
> > > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-sh=
aking procedure")
> > > > Signed-off-by: jianheng <jianheng@synopsys.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > index e95d35f..7333995 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *ioadd=
r, u32 num_txq, u32
> > num_rxq,
> > > >  	u32 value;
> > > >
> > > >  	if (!enable) {
> > >
> > > > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > +		value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
> > >
> > > Note this may break the platforms which don't support non-32 MMIOs fo=
r
> > > some devices. None of the currently supported glue-drivers explicitly
> > > state they have such peculiarity, but at the same time the STMMAC-cor=
e
> > > driver at the present state uses the dword IO ops only. For instance
> > > the PCIe subsystem has the special accessors for such cases:
> > > pci_generic_config_read32()
> > > pci_generic_config_write32()
> > > which at the very least are utilized on the Tegra and Loongson
> > > platforms to access the host CSR spaces. These platforms are also
> > > equipped with the DW MACs. The problem might be irrelevant for all th=
e
> > > currently supported DW MAC controllers implementations though, but
> > > still it worth to draw an attention to the problem possibility and in
> > > order to prevent it before ahead it would be better to just avoid
> > > using the byte-/word- IOs if it's possible.
> >
> > Yes, this exists for configuration accesses, and is damn annoying
> > because the read-modify-write of these can end up clearing PCI
> > status register bits that are W1C.
> >
> > I've never heard of that problem with MMIO though.
> >
> > --
> > RMK's Patch system:
> >
> https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches=
/__;!!A4F2R9G_pg!ZnsQc
> >
> 7LKbdCiIj_nLBkt44MRSL8W8YD4WvMmPNkHFlDMrjrVqEVOVA1-P-9BVE3Oa5bC1ymKXLNV5C=
9mJ_rfFtLW
> > Fg$
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> Thanks for all your mention about the potential risks of using readb and =
suggestions, I'll consider a new
> solution and update the patch.
>=20
> Best Regards,
> Jianheng

Thanks for Andrew's suggestion. I consider the solution of set=20
MAC_CSR_SW_Ctrl.RCWE carefully and found that the MAC_CSR_SW_Ctrl.RCWE=20
is efficient for many other interrupt status registers, and some are used
in current stmmac driver (LPI PMT MMC etc). Those registers work fine in
clear on read mode with current code. So, I think there is no need to=20
set MAC_CSR_SW_Ctrl.RCWE that will make a large impact to current=20
interrupt handler. =20

I try adding a new member variable(staged_fpe_state) to stmmac_fpe_cfg=20
that is used to stage the MAC_FPE_CTRL_STS value read in=20
dwmac5_fpe_send_mpacket(). And in dwmac5_fpe_irq_status(), use this staged
value and current value of MAC_FPE_CTRL_STS to check FPE status. The=20
draft patch is below.

Best Regards,
Jianheng

[PATCH v2] net: stmmac: fix FPE events losing

---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c      | 9 +++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h      | 1 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h        | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
 include/linux/stmmac.h                            | 1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.c
index e95d35f..8917fd0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -736,12 +736,15 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 n=
um_txq, u32 num_rxq,
=20
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 {
+	struct stmmac_priv *priv =3D netdev_priv(dev);
+	struct stmmac_fpe_cfg *fpe_cfg =3D priv->plat->fpe_cfg;
 	u32 value;
 	int status;
=20
 	status =3D FPE_EVENT_UNKNOWN;
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
+	value =3D readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_state;
+	fpe_cfg->staged_fpe_state =3D 0x0;
=20
 	if (value & TRSP) {
 		status |=3D FPE_EVENT_TRSP;
@@ -766,11 +769,13 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struc=
t net_device *dev)
 	return status;
 }
=20
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_typ=
e type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *=
cfg,
+			     enum stmmac_mpacket_type type)
 {
 	u32 value;
=20
 	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
+	cfg->staged_fpe_state =3D value;
=20
 	if (type =3D=3D MPACKET_VERIFY) {
 		value &=3D ~SRSP;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.h
index 53c138d..022c1a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -156,6 +156,7 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct=
 net_device *dev,
 void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,=20
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ether=
net/stmicro/stmmac/hwif.h
index b95d3e1..5496781 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -415,6 +415,7 @@ struct stmmac_ops {
 	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd5..6a29f55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_=
priv *priv, bool is_up)
 	bool *hs_enable =3D &fpe_cfg->hs_enable;
=20
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state =3D FPE_STATE_OFF;
 		*lp_state =3D FPE_STATE_OFF;
@@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_pri=
v *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
=20
@@ -7280,6 +7282,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7294,6 +7297,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, b=
ool enable)
 	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0b4658a..1322c78 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 staged_fpe_state; /* Staged FPE state when read MAC_FPE_CTRL_STS */
 };
=20
 struct stmmac_safety_feature_cfg {
--=20
1.8.3.1

