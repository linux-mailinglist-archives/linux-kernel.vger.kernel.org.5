Return-Path: <linux-kernel+bounces-30489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68769831F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5D91C22631
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB002E3FF;
	Thu, 18 Jan 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q6hZ8Wqr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b0GkwV12"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122792E3F8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604432; cv=fail; b=P/6LfCSC0rJs/b9ulp1/ogm9QrwieC9FDOiOz+y02gWFWMP98iuZoEmFF7QpDLlz57uecbarDzsZUMBHnmMjG60cpdXCIjZtA+mzPGhyLaI/ozaa8aMx4ouBd/Nx/L/mzsYz9jhQD0cAWEZj1M6QMp+K7zkNBq/qaCFy9u3NymA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604432; c=relaxed/simple;
	bh=GSLtv2GxQQ5Aia2FLY8wz4Z76u4Uaw2PTQ5z9mkvCuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmhWnulGvpVbrAWwjul+MJspQGEpuQS7qKhtasu0y2Z5Dees5HAe9LpYLb/+VUYSv4YZIAwOHobSntw+aX+JAOQF1EEt+7E0dWGzuJNOUfwlAR0SotCqdQn65ziJLZkMgcdGLmUORu2R0d4zit9kiu6IUBe3M1yGaL1/bzE1+R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q6hZ8Wqr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b0GkwV12; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IFSg2D012862;
	Thu, 18 Jan 2024 18:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Fp+N18n1mkMVgEABys/IcTsC2/i60tVPcSjNi751v+4=;
 b=Q6hZ8Wqr4JMcq98oxIhO6vt2xCT0oxQCyn99J7SWlrwS4QtCq9uwjEZzbzBNrA8rpNYx
 ZcZRdkur/6z8KlsB1QI5tP2bgz9A7f8nu1TUnW8PTDgGz0NuogxxIkUbl7wl57ULvpI0
 l2FngSR+emJWmCN90dhzPFFGHHdh5HOwye2pmh/5GQN97YBGPyhcphRJWxFrkhlq4BBB
 pORE5YsFTCdl8iYul3LilQ4kR5vhjTCSakZGDrzJby/f8o/EKlnCFLllr+4qZB4xWS4C
 hQirmZ8Lo7zAH672oaBD35LMdHnW0G3LephkdJJ48q9aLwVt1ctPN0GOLZp0xcO/3V5j RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3ku65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 18:59:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40IHbcfQ005098;
	Thu, 18 Jan 2024 18:59:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgykc03u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 18:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPWgCvzJRSOmGmelIYMKDvw4GnPmN/BEPsaT8xjuGO6Qfb9uJLi6dGwPb6VzIetGWZCdDzuOOHrY0gP87Ox0TBJCVv7Ou3+w4TyLj9lq0xQEmhndR4kOAvtD0FmC7b0f3lrI8QGgdVZ8zOqNBUPk1XkWfgYtSeBZyDuRJ4Wx5mNfijt5ArJOlpFlUGqNJRK7MBiJtnwA/pLJTaCCF62NF60I7MhOve/DCOtsG1LfVE5SHd/O7a9cgae7J2FELAjK97cH5qsbfUxcASl7U4E+F+BhQkkt4YDb/7dLfsUpGMqRMi9GxE7kC25KRtAVAYIj0ziv+oGl2C7qt5XsG2b0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp+N18n1mkMVgEABys/IcTsC2/i60tVPcSjNi751v+4=;
 b=MXVCjpuHB4pTRrjUBYMPBwltpQbeTUMBH+uOaxGoNb83gqyu4n0LLFeibaA5919XK1c9hO3XUmVYO7eWrbHp/v84lfO+yyv9KzKf99foCpY5ta8kZX1LDScr0skqyiM/eCOdwZG1QAjY+R1xuj2NJEmhoW4pQngsOxfnexN1eI559Gp+n+UQ2Wa1VSfVctaGMNzEN5xfUFXLTnCGNHX32yGkdom2p06eXy3BZaYZgGjQApqlO2uoKwOYZNXBHNXDHjuE4mDIH9fdC8yWlTcTOdtJsoCxLPKAq2RjfCGk/uXVZRYDgk7+b72G6AX4gv1EJ00bb+gBfsvIhra/lVznuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp+N18n1mkMVgEABys/IcTsC2/i60tVPcSjNi751v+4=;
 b=b0GkwV12jTqDoPw7FXFhfgICKZQ83sp4rmi/yLm6xMG1MYro7xsDGBD6Wx/l/JmgFxZuq1oOBoP8RCDUW4t3T83MYa71gFEhPzW2yqveW6oAUjyQIyMpqC3hQD43eo+ZVZd63fZxkyYgATCCzW91u1Pr7W5/+tpflDKsMO97qc4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB6699.namprd10.prod.outlook.com (2603:10b6:208:441::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 18 Jan
 2024 18:59:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 18:59:20 +0000
Date: Thu, 18 Jan 2024 13:59:18 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Christopher Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei =?utf-8?B?WHXvv7w=?= <weixugc@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Chun-Tse Shao <ctshao@google.com>,
        Suren =?utf-8?B?QmFnaGRhc2FyeWFu77+8?= <surenb@google.com>,
        Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
Message-ID: <20240118180959.gwqphdgmf7r5sdne@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Christopher Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Wei =?utf-8?B?WHXvv7w=?= <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Suren =?utf-8?B?QmFnaGRhc2FyeWFu77+8?= <surenb@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Chengming Zhou <zhouchengming@bytedance.com>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d98c5bb-dc14-4fbf-9b63-08dc185793e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6/gPvLXo1V5lWX3k7FeNM9BVYdQwQGdoiO59g+Q74GSi8Fbjg8xGR0rs9h58hgYJrBNWLGKQ9MYLoAsq6J1/joj+3Y7iZe/6+RS4N52ADx1fg5YPfa3Y/ZWvKjvFnewwIdyD57jxXj+ozcIVLTYAIpjMNJx9Lbx79laH2Xu6jc8i4XnPBbKXuiJNtlLWHUHXxDV4eEm9sBGVvXDGWhrWKKMhiflOmId+6FbnTibNUiCnNfSkqJvBw65z85z6Io/nvf4efdwnDLYzwWQ/mH8X2x3Z4ov0CroGz6YvCAqJO59qb/E42+edWCKu37WaDhkPbR/OsdVuGW24JApbnHv5aQcwoM/FHM+kx31825iwRAWaTS6p99WF6ZYvAdl6h8ziT5FqW9YLtYvj3ZLAVPX8JTCWbVVyG/pBCP4TKjPKBQIKZoaoidet7xcUsXNSNFzDT3ae2dcOgd4WPsoZ/xmr7nbhURA0hzMDypNUAOXaJfEkVz/qtHHW+ohti8v4umkS4pAv9DJ5uwG2WHJnA6MHyDdZj3n6YOU5et7mtxpBH3vk2U/ut2BtQs6F5T/NLkqA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(7416002)(478600001)(5660300002)(33716001)(4326008)(6506007)(26005)(66556008)(6486002)(8936002)(66946007)(66476007)(6916009)(83380400001)(9686003)(54906003)(86362001)(41300700001)(6512007)(8676002)(316002)(1076003)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVB5bi9lUS9aTlI4R3pqMjZIYjRFZ3ZGTW9Mcmk1cmd6MDBnQ0luNTlpcmRY?=
 =?utf-8?B?aTBrazJKaXYwbHR1SlRqT2ZsTFFtMlJmVTFVTTl3d005Q3p2dWgrRU43Vkty?=
 =?utf-8?B?K0ViUzQzNlZMTWpQZjhnbStWTlZrSCt5aWFlSEZqVmZNcEdOcnVzcWdmOWF0?=
 =?utf-8?B?dU5DQ1U4cWJ1TlZSQjVyalRqMVNhendieERPd1d4WWMwRFAvOHNZUDkra2ZQ?=
 =?utf-8?B?WlRUaXUvZFJXRzlvakMyYVd3YnU0KytQSURBT0M0d3lXMklqVW5ud1RNeUp5?=
 =?utf-8?B?UEJ1TXZKTXBZTDVIaUF4Rm1KTDU5VFh3QmltL3NsQ2JCNTRXVnBrY0M2a2xk?=
 =?utf-8?B?UVBmdzU3YmxIVFJpTXpZcHVFNEZzbEcvVm1vcE9raTVJR3hhVXBOZUNpYmtY?=
 =?utf-8?B?VnFIMFBRSERaV0VIb04rQ2Y5aFVDMVFUTFRtNjhqNTVYVm1mV1NRbjlabkhO?=
 =?utf-8?B?NjVLU2thWFFqYnU0UkVqREVPR205MHo2aFhyQkNUMG9hZGw3ek5WSTEyN3lN?=
 =?utf-8?B?OWJBM3NkWUpvK3ZuaWN0NGZHeVE4K2xoYTU1VGxoQ2U0RjNLWjZkWndvaXlp?=
 =?utf-8?B?NWYvMEhoWXNSa3ZQcWljcE00czN2bDBDdDgwMjNPeEtSaFlqN2dyd2hnWklV?=
 =?utf-8?B?eEFabUFodjFSQlZ3R1paRlFOcEw5cDlkbGJpUVVPWno3MHBUdE5ENXBRTlB3?=
 =?utf-8?B?eXl0UXdHaXZHUWs2eWNuK2ZqWElWTHFVQW4zZCtzdkI2dDFUZGphdWh5T1dn?=
 =?utf-8?B?ZGhqOExjRkJJMDA4azlUSjVBNFg3NWU3aEd3RHJ1MFZCOGE4SmNGSWN0VEwx?=
 =?utf-8?B?c2NYMm5hbnNUQWZGeUk4SzBia08ycFRmbEdZSlBYZjdWbjJOWlhSTytmVTVi?=
 =?utf-8?B?Vlo2YUt4NHd1MkVJK1pGcWd4aVlCVEY5ZnBrdmhla3d6Q25Ya1BnQkhKM0Ur?=
 =?utf-8?B?YnlyMFp0SExiQmxSa0NiOEVyRjBXOFF6ZjBDRk1WNWYzRDRGNWxGaTl1TzVR?=
 =?utf-8?B?YmY4VWNCNStnRXZqNWZ2NkFmSHZmNU9HTG9jNjNGclU1c25XYzVUYTFJNTZV?=
 =?utf-8?B?N0w1RTJqT3dzcTdxTGt5cXVWcEdxTDZHSnNUN3hONWxFU1B3aVR2MXFpVXNV?=
 =?utf-8?B?dlVnZ0xobGNsYy80dzNsUGVDS2lCQnkyM1B6U0ZJZmlPd0swUGN0dXlvRVRz?=
 =?utf-8?B?dk1oUnB3ZnRRY2JsNjRtbjVrV2ltZm1LTkVCd01nMnF5a2FpbysweW9KZDZL?=
 =?utf-8?B?OGVUbyt5QUNoRWRiaXB3Yy85Yy9RTkxLekhobmUzTDdjN3hycFV2c0MrekJj?=
 =?utf-8?B?aS9RczlYS0FDbnEwV2hxRTVwa3BYLytZVzByM2pnV2xDWkZ4bVF3eWE3OVlM?=
 =?utf-8?B?cVJzeXQ3WkpHMERHVXk5NUJQbkl2M2puNXpiek1Ld2JwWTBweStwM2hJQk5m?=
 =?utf-8?B?ekZLZUQ5U3lGeFJNL0dFY1RHWmJqUXREOUpoUURJMW9za1VuOUhMUDZ0VTNy?=
 =?utf-8?B?K2w2ODMzOEQyS3FmOFAxamdKNll4a1dXOUhhU1AxNWx5UTI3RXRWZnBmZlFT?=
 =?utf-8?B?TG1lN0dsOUJJU2pJNnFveHFMcXhGaks5MlNEdVZodjBEL2E4QkhObjd6N25F?=
 =?utf-8?B?cXhPZXhuWDdtK3dWMnZoMlg4TnYxNC95T3VwdUF0WTJOdVB1M256TDRTQ3dW?=
 =?utf-8?B?Sm1PQlFhQnJzVGx3SkJDUzRGMDdERzQvS095NTZMYVMrcDJvaldFbEZRVHFr?=
 =?utf-8?B?NS9zUHd3MnlvRWxhSU56djgwejBrME50VXB6SVRlYnEvN25pRlZqbFo5eERk?=
 =?utf-8?B?MW9uZVc1Tk9PSFAxZm5SYzlVNitab0pFby9QSVFwcHlxVmtTRkZQRTVibVVB?=
 =?utf-8?B?VklaVnRqRkp5MjJHTEZtZzVPTEhITlEwdjRNZjdBaEprZUFoTGQvK2pjcnk5?=
 =?utf-8?B?WG04N1BTT3FHNlR3eHhKMFJMb1F1UDJEMVZRWVVQbHNab2JrZktJZFNtVW1J?=
 =?utf-8?B?ZHNlQ0pQZ2Ric3ppSzFQTkFaRjdaRGN5a1FIemNmRkdGVzAyZmNmN1psQXdY?=
 =?utf-8?B?S3dUU0tSSmpoYy90SUNTaGkwZ0tYcEMrNTNTdFFtSWtuWXdVakRscDlINGtW?=
 =?utf-8?Q?8uupax27XO2NWYMj3v+hnet7d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rWcrqyVnVGafdl46WS79FLy22d5lcK6KHNgFk97u0PuJjWfpkhyVf/bw1piEvwtdEp9fVYljXzL48VjAoaTX6tprI9UTd9lds0WYIDYcBUGn3btgF2AWkPKJ21XSGi2r78yIW5UWk0opB2Z0mym9uN5xChZ5uWHW1Io4WPWHSRjA9xTmniHdbP2upM27Pn3pbmE5uIRsTb5ah+dQgtD8TZ/9I2wqUi1EvN5l2acNzZxIS8e4ENbZVK1rYL6Y+/IiVTPI0WrQ28+/g7ZQCqyFcn7auMpkiIGanN013s3axkBzVyibO6wna1ZP2gEYxrma1ZYau9N8fXS/fWM1y+iiqY8FMa3gyMh8w/f7EbgK+8/6H/TfXs4iLtf2uAqo6rSuvf0h/bVA5IpFcvLKirS/JOQG9sAH3kCrvLrfZW/JIHvRgRO4NjtCxglPqUs17REWnaftfs5RQt63t07hImRAgQCUnMzlG4xIuvKXt6PWZ7eOQggpweO4p8f4GGoFisUK9uJZcyoYAjmxj0MSZ88IHxk5lYP5agDyaO9KTiOtd4yfcwwDsFELsx8IsrGN75JNHXGFz9l0ep4xqEwR7o/7hgy14J71Eo6gtZSsW4RBouo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d98c5bb-dc14-4fbf-9b63-08dc185793e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 18:59:20.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42UJzOq0t7o9fmWkq0Fi9/0snZdWU2/BK0yTq7S0AFx6jNNQczmxYen2QWqmMcJM5hIZrRt3U87VC2CK/5vY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=603 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180138
X-Proofpoint-GUID: BUkHo3FvUlIJ-StYWUq_TQFOM47nHTxd
X-Proofpoint-ORIG-GUID: BUkHo3FvUlIJ-StYWUq_TQFOM47nHTxd

* Christopher Li <chrisl@kernel.org> [240118 01:48]:
> On Wed, Jan 17, 2024 at 10:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > That's a long CC list for sure :)
> >
> > On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > The RB tree shows some contribution to the swap fault
> > > long tail latency due to two factors:
> > > 1) RB tree requires re-balance from time to time.
> > > 2) The zswap RB tree has a tree level spin lock protecting
> > > the tree access.
> > >
> > > The swap cache is using xarray. The break down the swap
> > > cache access does not have the similar long time as zswap
> > > RB tree.
> >
> > I think the comparison to the swap cache may not be valid as the swap
> > cache has many trees per swapfile, while zswap has a single tree.
>=20
> Yes, good point. I think we can bench mark the xarray zswap vs the RB
> tree zswap, that would be more of a direct comparison.
>=20
> > > Moving the zswap entry to xarray enable read side
> > > take read RCU lock only.
> >
> > Nice.
> >
> > >
> > > The first patch adds the xarray alongside the RB tree.
> > > There is some debug check asserting the xarray agrees with
> > > the RB tree results.
> > >
> > > The second patch removes the zwap RB tree.
> >
> > The breakdown looks like something that would be a development step,
> > but for patch submission I think it makes more sense to have a single
> > patch replacing the rbtree with an xarray.
>=20
> I think it makes the review easier. The code adding and removing does
> not have much overlap. Combining it to a single patch does not save
> patch size. Having the assert check would be useful for some bisecting
> to narrow down which step causing the problem. I am fine with squash
> it to one patch as well.

I had thought similar when I replaced the rbtree with the maple tree in
the VMA space.  That conversion was more involved and I wanted to detect
if there was ever any difference, and where I had made the error in the
multiple patch conversion.

This became rather painful once an issue was found, as then anyone
bisecting other issues could hit this difference and either blamed the
commit pointing at the BUG_ON() or gave up (I don't blame them for
giving up, I would).  With only two commits, it may be easier for people
to see a fixed tag pointing to the same commit that bisect found (if
they check), but it proved an issue with my multiple patch conversion.

You may not experience this issue with the users of the zswap, but I
plan to avoid doing this again in the future.  At least a WARN_ON_ONCE()
and a comment might help?

Thanks,
Liam

