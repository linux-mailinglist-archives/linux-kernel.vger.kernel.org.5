Return-Path: <linux-kernel+bounces-34807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C18387BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5142E1F247E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3551026;
	Tue, 23 Jan 2024 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWC0AtaQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cW3GZ60I"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE883E491;
	Tue, 23 Jan 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993344; cv=fail; b=aTxN5FbIuxueGSowtdyvLfXwsO55ecWRVRF0tV+ZsIzS9y825dPBVMnKd0ccQ2jxjtXt3V98J0lk2b5rJFUOGJcGn7YceBfUtn5UkNlMyhpn1gLgpz3sen0e6kByKCNCe1fW9O1SA6DmkM6JjSRyAfxpk24bLiOIu6wNfAPfaXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993344; c=relaxed/simple;
	bh=Z+u3wtzYGJXVPBmCnfzklxwp2ma/wGDgK/Blg9koN0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVDu6o7KabEP7XIIwfyvXI5ITwvYJcMS8OOq8z/xg6Se/639BpkM0zROGrkB7CcL17+pQ3/i221FiA/3DpmNjOAv0ovqVk61hKTfqlozRFmDZFNhEND/H6/BiOBRTZOaP28id4p7pNEDTmAkso1GgW7OcRFL4qiZWbJFFNgFLSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWC0AtaQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cW3GZ60I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N6YxhJ006003;
	Tue, 23 Jan 2024 07:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Z+u3wtzYGJXVPBmCnfzklxwp2ma/wGDgK/Blg9koN0w=;
 b=lWC0AtaQxY3UqoP5Y6cAmlob7oggYJIKOaqOrA/twCQXLw6IVvtwGgfsitGZicGV2xOH
 rdXftGaC1fAhryaeuYyeuc8pg5SNx00AbA0Xq/Rp0YWmeryfFbDq5ZDSXmuiiTlB314E
 +QSRuRi4K6fnBdCKKiVJBMRgdX0G3Hb1vhDLTNLRtgkrpitPxdIb2drE2Y3aex6JZc3R
 MASr3va5U7x0AVwaCwC361qpMf8GhEpFS/YWOO9NE5pXXrtnXisaZf34RG4RpqjYV7W2
 0IA4KmkI+qwqOvIxCIIon7IGoCpyK16qVTb4NbanLpAlADzcVLr6I/OMB41T3OJmkrF7 nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwdgqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 07:01:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N6VLrs016258;
	Tue, 23 Jan 2024 07:01:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32qbke5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 07:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjOoTou+UsVVL/qnzzL6bTcLJMwc5oEIVjsudnTDY6JhFnX0xiDrjbkf7rjxpGsp74B7KiJi6nRmlLUP2SsBVO3IuHMfSkAuYQ8OfLXhibOulkLw+QnkYAXwLPwkPnS+3IEntG8Y5qyKRkQWQ94bJ4FzIzGgr4zHHJgIakmXkxqj2F3a1cffoBHo68tTpE4i+uDoJ6IBBzillBz8VgI4JK4k97X4aLfUi3/4lsoGF86SQQYJ3l1fUF0OZSZjPntEZs8OKlsCT97cNa5yIdSLdkaA9PNzfXOHbhREiGMtorE+2naW0rwtTPpZM9U9gFXC23++0teMlIosrWS7o8Zpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+u3wtzYGJXVPBmCnfzklxwp2ma/wGDgK/Blg9koN0w=;
 b=ZfEKwyijUgJkIN5Ct/cGuP7K3LBCU0Kq7Yp7NWpwWIPPoLl7wTQEXaaSwm7D8rnoL+Z34ZaOCVbR31I9+6LW70+u+odJHFLM2TQrPUzRrfdxQ6WbIi7EEmh5WWDjHApXzr0cnkJH66+1XTCqvANYgjv62RlqZkXQA1CKlggDa2kmTxJKBJSbV9wr/3i3F0ij2/60aPdhX9692o2FrtMYVKEL+5x7umJXaJdljC6UYbMwvqEes4B9csVhkbeO0PUBCVU1EPT9gvvMRngkKURUWVPki3uaqlyHgFBW01Cw9PdQRb0Fs333Esb0KMrDsqpl9Kx2iRUFtNxUmqQ9hrreZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+u3wtzYGJXVPBmCnfzklxwp2ma/wGDgK/Blg9koN0w=;
 b=cW3GZ60IEa7KS1NC1omaRLgb0G1QbJId5Nj4dHWjBY8T46bjEAvkaPoZ1XuzPedd6AeOPBmwYUEPNNLLAhtFWMaAMuc03EnNWE3uQJAR/FC6XCnjlrEZjUqWE3+/IyHEICs/gT11sum7LeY3f3m8LWixQTVqmGUbuiosqfO7eoo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7033.namprd10.prod.outlook.com (2603:10b6:510:276::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Tue, 23 Jan
 2024 07:01:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 07:01:49 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: tglx@linutronix.de
Cc: ankur.a.arora@oracle.com, david@fromorbit.com, dchinner@redhat.com,
        djwong@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, wenjian1@xiaomi.com, wenjianhn@gmail.com
Subject: Re: [PATCH] xfs: explicitly call cond_resched in xfs_itruncate_extents_flags
Date: Mon, 22 Jan 2024 23:01:58 -0800
Message-Id: <20240123070158.4023269-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87v87yiu2g.ffs@tglx>
References: <87v87yiu2g.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ffb80a-1db3-472e-620e-08dc1be12b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gAkd+l9xmiXeah4sA9DPuvUYS6oQsYSCyXsZKkahDwXU4+jSlZpeua/F/FavnUC1/BjTWPX4W5H6pNasMhx8eCJ2svpNaEp7Jc+K0mjRhgTeQCr5rWzkwzEBoupqiYY2hwDyhWzucZqOizw7z45Vcx4nAyORvqfm+3NoD3JXvxXkdZ6Viko5AI73tQTwcwfz+ih1ph53DbC3/gfSeErDY0tPwHRIjnNbPEJ4ryzIFBTg01WEKOaLH3OWcjMRIDMGTJQ9A8CeqemyHo4rmPOWCaW4Kmltr/lEMRDYJia9irkI5nRf/FLTZFWCqGvZlg2b9wDMHCwez2eRHQxzLn8Jm7OGtv6oXH6ddptQ4ZfqwVAB/uA9IbfpVRv5/yUov3aPNU2vo/Qz5wkUfQXPXPxKe2SjNQDaXM9zg6QlThdXA0owlf79EBJBrr/UqW238GVQj4EylIsyM2yskFgAeBRQrXUI9KPoyTdpxEylOuuDPW8YZiM7bNrz/Idy6wuGaGS3R0uzqaXrqBJCkElQkXxfH3LvtVcigRZ2P3L19i8T7HICZBaBuVXXLJt9rJ4xtWpF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8676002)(8936002)(36756003)(316002)(4326008)(38100700002)(103116003)(86362001)(6486002)(83380400001)(2616005)(6506007)(6512007)(478600001)(6666004)(53546011)(6916009)(66556008)(66476007)(5660300002)(66946007)(2906002)(1076003)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3ZTcTdDWVNFWFdyWlhqak1nRXZpTXVjTmZZMC9nV2ZDRXZjQUx4K21nWkJP?=
 =?utf-8?B?bGl6Vm1IYUthSEN2eGhuU0hXWldpMlAvdmozdjJJanB5cnYyamhxLzJUeHVy?=
 =?utf-8?B?WmdXZmo2ZDhBekNuWTVwSC82OWhSSDNpa1lIT0Qzek1JMEVGa2VrZ2NQZUNC?=
 =?utf-8?B?U2tFVUd1UnRQc1lOazJ5YWtCUlpORlJpUnJ5TkdWSHZaY0Z0a2NWeEtwY212?=
 =?utf-8?B?R1YxK0VBWlFoRnUyUWhsV2JhQUNoclh5YzZyWThic0locUtlNmNqUHhZY3FR?=
 =?utf-8?B?N1ErMjkyOWY5QklvYzB6Y2Ztd2F3eHpYdUt2cTV3eHV6VmNCRWV5ZmhiaC9i?=
 =?utf-8?B?SjFGOHVmcFc2NEFINDBoQmNoUFAxR1c4ZXp2NVNyY2REelIyTTNhUlVySTB0?=
 =?utf-8?B?QnlubURIdEx6S2g1YXpRZ3FCYUV3RVArN2l3aDliNEtMblJZU0FLWk5Ed2tw?=
 =?utf-8?B?bFNjU1NjRnBVK0JFb1Z4Smgwck83Y01sZGN1OEh4aHpOT2ZXNHhsWllYS0xQ?=
 =?utf-8?B?RjJFZjRoTzhSZkhYSkozdzhZdGJnTEtSQlhHdTVsS1NFZ3R1NmxxQ1hMTHoy?=
 =?utf-8?B?YlIyRlBoQzQ5WWxLUmJIUmNQMWxMNVhMUnIrNC9QdjRVaU10T244Zk9aYXNs?=
 =?utf-8?B?S0liZ2ZBRUFjZ1V1T0dmNXJmMkdJazYxL3Z3OEVrRDM5WnRVOUlVWUFEaHB3?=
 =?utf-8?B?eXRIaHllZXcraW1aNTN3czcySEpqRDlIWmRlaDg1TmZkVlBWVWFCSVoyUnZs?=
 =?utf-8?B?YUoxU1VhQ1R3WTFKajV6NXZNK0N3SHkvOWNLQ012RlNEczNFMXVQOWFxS2Vy?=
 =?utf-8?B?b2g5R0xUNzRScmd2SjF3WVcrSExaSit3U1NlMjNCbUZJaUxJU1JjeHRNQVVi?=
 =?utf-8?B?NW96OEVUMlMvNk9pUzQxYWtZRHF4R0l6cE8vK1p0RmRjS0pCTnFGZVo3b0Vn?=
 =?utf-8?B?dGlCVVNKVUhKbTQ1dkc1eDNDc0lLa0Q1UWF0RmdkZk1IZWEzL25ZeHZDMHNn?=
 =?utf-8?B?ZlEwcFRPMmhPenQrcjJvN3BCbzcyUktqWHBNOUc5aG9UU0J5MHkzdGJKZkhs?=
 =?utf-8?B?WW55b3ludU9PK0xxZzBUelhXMWFRZ0F3QzBzblN2UnB0aXc0Nkp4dWgyTUtk?=
 =?utf-8?B?WDlQTFB0YjZXakVnckxCZm5YQ0VtNFhsVHNjSkFKaGE4bVBaK1R0MytHTTJX?=
 =?utf-8?B?dTA5YXR4dmVSRDJhQlV6NDNtelNDUWlKZEZhT0VFZmVQNndrWjF2K2szNGM2?=
 =?utf-8?B?RkRPTy9rMG1CWGlGN1gxa0k1RGlCNmtMMjhsM0JicG5wOW9nanFNam8vZXVZ?=
 =?utf-8?B?NVR4YWtmNWtxSDBBcUpvOElla2hVNFdqZnVRNTVvcGY3M1J3MUhiYUl2aFly?=
 =?utf-8?B?dmNFVk9FN3ZyL05paXNEZmJZUGM5K2ZHMnluSXA4NjlNaUNvSGd2UmFtNjU3?=
 =?utf-8?B?MFZvd2loM0ppOWJkU3o4NEJxL0pCSkxSaXNpclR4OXFkT1FLRkhMK3pFczhR?=
 =?utf-8?B?OTkvUXNkdnRMUndpMi8ySnFYMEZtNFNFZzNNbDA2UnlpRVBYbDRFVlpoYXh1?=
 =?utf-8?B?UTZ6cW1HSlhDRHM3bm5jTGQrZDdqd0RjUVQzVTdyT3k2RDI4N1pNNkhpTDd1?=
 =?utf-8?B?S0NZd0swK2tQVEZRZGlFd0VpYTVRUzUrSlFSWEdLU0g4c1RabkQxekl1OHc2?=
 =?utf-8?B?aGorcXVtcCtLTDU2QVZ4Z2p2azFQR0NvejY1UFd0REtkVHYrK0h6MXVQVWJh?=
 =?utf-8?B?VktnZ1NrKy9UeThJeFkvdUg3UytlMEFiZ2VINHU2YXl6NFVPMVh1dmk2VkVR?=
 =?utf-8?B?a2FNWUpGejVFM0JNYk82Z0syVW02V09rWHJOWDNEUGpMbGFUL01nOEJLR2VO?=
 =?utf-8?B?LzlTU3pyakwwb0ppb1M3ekhFUzM4M05LbWc2NmFnMlpDb0l1bG8zNjNoKzBj?=
 =?utf-8?B?dW05ODhRR1pzazdoeWVwcDJycFNPVUNkSDgzZ3A3eG1UOUhYQlFzYlh0M1Vn?=
 =?utf-8?B?MnNYUVZGRXYrWmNsL3IvVFc3VlM5UExKOTdRSXRiZUczV3BxK1pKd29tb3NQ?=
 =?utf-8?B?enhzY0ZaNWc3MWFHR0tETGJFcmhhVkhEMGJOVG0rMUJjZzFKR2VGcTBxcTdm?=
 =?utf-8?B?d0dUOEo2djkwem1XWGlrS1E4WTZPeGl1K0JhaERtLzdKbGJXTDJ6d3FwcUVN?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pYCDL8qI+rMu90fLx77zOIvvEwlQJZIeYE+uhwhxGhT7gvXRjS8TJuHJ3hYjAQMQ/iMgOu71iK6gwH7jyuZTxZNgMlpUNbKuK+xcd9qi5vMipgc8fcxokE1J9fiRy3Wa6gvYKvB4Lrvf0ZuqHFXU0WJE/Q2DhKp5SgVux+I/iZXD2DyBVqk/B9V3BQNEj8TjUYqnjIuoG/jJDe+NOFFCHD9mCNOgJomNrz1fdXheqsf/9YHF9mgyDSWIPK9U6zTbhJDePyk8pynOkiy6uDWWC4TezTmuqMUX/EBrj5JORaAhEmzAROCzRCB7s/A8jLTGIXvukRdBGoZQtTmg733oFgIDH1WRcd/4aeF2PHEhRZzndUcDFSSZbkzlN5eN0t0H3ZcOP3Lj7KHC+WYCQceK2YWWMp/rGGreKzIlkKG9dc9y7cxudVt8iJKklFybpjQ5aBitNe8W/FaHVTvaK4YBWdMCP+Uyjph0pDJJRSw+l5FLHhWOuZ3eVqXba6O5shtXxG7PDUQfgLkQlpbyxrn2FCgFxGpu0RtRMyhAXRiKmNVeAht4Y5q5EeCW04Cd1hN5sprSwzVea6xg7ua59dWzz6gNU/ypEDhW4lrYJEMARaw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ffb80a-1db3-472e-620e-08dc1be12b84
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 07:01:49.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIIduoa3PPSZB8sz/yQqVkKCMpEcXuqLHVGOtsBc9asdUKOTovar/5MbIasolE1P/eyb63Xq4pGG2aUnL9OCZmT2jT1gat/7aDzoFfE3GZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230049
X-Proofpoint-ORIG-GUID: LTzdUHDi2XjvvtIeX3182Pgrm0HA9n3R
X-Proofpoint-GUID: LTzdUHDi2XjvvtIeX3182Pgrm0HA9n3R

[ Missed this email until now. ]

Thomas Gleixner writes:

>On Fri, Jan 12 2024 at 07:27, Dave Chinner wrote:
>
>Cc: Ankur
>
> > On Thu, Jan 11, 2024 at 08:52:22PM +0800, Jian Wen wrote:
> >> On Thu, Jan 11, 2024 at 5:38 AM Dave Chinner <david@fromorbit.com> wrote:
> >> > IOWs, this is no longer considered an acceptible solution by core
> >> > kernel maintainers.
> >> Understood. I will only build a hotfix for our production kernel then.
> >
> > Yeah, that may be your best short term fix. We'll need to clarify
> > what the current policy is on adding cond_resched points before we
> > go any further in this direction.
>
> Well, right now until the scheduler situation is sorted there is no
> other solution than to add the cond_resched() muck.
>
> > Thomas, any update on what is happening with cond_resched() - is
> > there an ETA on it going away/being unnecessary?
>
> Ankur is working on that...

Yeah, running through a final round of tests before sending out the series.

Dave, on the status of cond_resched(): the work on this adds a new scheduling
model (as Thomas implemented in his PoC) undwer which cond_resched() would
basically be a stub.

However, given that other preemption models continue to use cond_resched(),
we would need to live with cond_resched() for a while -- at least while
this model works well enough under a wide enough variety of loads.

Thanks
Ankur

