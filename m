Return-Path: <linux-kernel+bounces-29419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35B830DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D9A1F23929
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E72555E;
	Wed, 17 Jan 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UtN1hyde";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jlccRGw/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE325545
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523489; cv=fail; b=qC7lV6QZBJ2zRvCAz57lGo/CQgMUQo8QcQjmAvP2e91TFMJizkLG2uXU5mG3YtLBswUaR5ht1rtDNdWV4l2W0Jlc/3tWPHzFgf8uDl4TE0XUW66SmgSSzdDkBdSisgAODHY3SkKgfcLyvQijOZ56wO1MMvQChqoI0DebNcs0ktg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523489; c=relaxed/simple;
	bh=yuwsOb92idyqZ+UUPqyW9TD03zsBcYg1biSulngBsZs=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=tsb3svfn/tBdz6ZAGoildqe7KhGH5SqDrOzQyrlGAVbWiT5m80ZGLYQgQ4QK94zL1l4/nrxwXzDF4/7BtVV1nYtR3IApmyi00EB+RcNuplFGYIpwJdvgRaSsVKnOoeMurCmh3gkRe+cX2bSuJgD6qpkBiHewVOPC79ExrgxsjNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UtN1hyde; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jlccRGw/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcm2M021380;
	Wed, 17 Jan 2024 20:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q5A4rb9XCi4Z7I8Ita3Qw7RSYV1PT2AN0J9oB/0gVj4=;
 b=UtN1hydeY0zuJ2wJFBT4cT6oOdmn12dP5PaMmhFMdB4vOKlg1x14VRvzxxiyUb8H1fcv
 pR8eWq7fHGQpZImucHDpFehofrd0CbYGtiIESF4zvf7js2svw3tTLFNKIOAzR4FlpmW1
 rQ9Rl2K6pzH2foFNJkbhAE5VMproL8hrj/SffcMpEfhPlgqNvBRJlOI+lyLYw7JGl0ZA
 h8Z9UlJOmP18xBgao6HDobFgKe/ggRbEV262BXNaunv7agcDijwu7bBgvxqlTcdZtDWT
 34BE0qg3KTKm2/WOm+cXtZZndjJJqYIJiHcDQCm7PyyEYwYJcTDuxGoxmrb5UGMNU3RN Ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3gyjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJ9MTp023275;
	Wed, 17 Jan 2024 20:31:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb2dpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl4idv1uEWrR9xqWnivlEE4kbJGbUp6yCehotfCF0AExYcQ252Tw4VKuMVJheFnNVHuOkN7Gj29L6OojhkhHtHxqxZtmpH47yfEVPtUDp08ShX2oXC2/ySGULSSyjxRDKkOUL9YZkrfedeRf2JgwHT4esd+jboCUubg3IKKbTiRujKXwyYndJZoZyXNFXOJ0cFIs7CHv2PnIE8DRW0rXvLoXjQGi+YEiTnlvZPyIPys4prEiceovcCHVFoDd/z/74oyrX3Nnxlk8ExEpSfakZDxvSHT8II7M8kxYIN3JHvuh3DTU38RYmnTD8nsC6CFx45QUJdSBYas0PIpOwBUnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5A4rb9XCi4Z7I8Ita3Qw7RSYV1PT2AN0J9oB/0gVj4=;
 b=hyEaJ948hQUh/upbz3+IDY6BE5/NYnzTlii4ZS0ji8bpDOgAP/mGqK9ZA/wEUnK0CoIPxBOcFWX/PH52LjJtPfJDX/S5xedmwS7l6avVGaTkwQQv2VlJv9v7/f/TwXUVWPPjSKrcQ2hF8jFH4hrL62nX6Bekl2++wOWANPNf2zdPj8M7qD3iHIK66r+lecMG+bGVAE75fLMTmqn+cfWpLTTb4E+YBuxfxTg0JjnBBQ64iMtMF5+2CDnJ2tf2nETYIH7u2C0bpPUFL/yeX++sIg9CchbZhZB2kL9Fusi38rLgKOo4JQwveZd2LfRW90/AqKDXR48G4eblg8RBSLINLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5A4rb9XCi4Z7I8Ita3Qw7RSYV1PT2AN0J9oB/0gVj4=;
 b=jlccRGw/OhPyGaeaGtAW+OsYW3/Xt4wrtYozK/fE012i5yMJGrjFYNqgs9OmY7vMPWj+O0ZMiPTaq7a+JUg96XGCkVTf890d4oWVjcctvQp2cc94tR9jgG1ziFGTHz48kL0jCnYVIzPZQT/EO3+PVzKRAY7Kkkcd/Tko8z1u70k=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 20:31:08 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 20:31:08 +0000
Message-ID: <e87ca0a4-9912-441a-b31f-d11c41ad6f5d@oracle.com>
Date: Wed, 17 Jan 2024 15:31:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 10/13] vdpa_sim: flush workers on suspend
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-11-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWdTBexyY-ra=UkUfUU75YS2Zncm5-9iHv-0Rqa3_mD=9A@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdTBexyY-ra=UkUfUU75YS2Zncm5-9iHv-0Rqa3_mD=9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: a3217d26-2dce-4ce5-bdd0-08dc179b3cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DJewf57m6vaDLDZb536EliicRvR/le29E4FCtipPegKBDkpc5xk7hgdEJDF4pIpbtPMug/obZt2C67YVb7LEMhY4q+JG+J/MMdZ1+CjvCDYV4DPxNu5Gl6upO5SnNujT7lamKEsJVHXwiZHmZgeaopNGTkHEE7c7VTmDMgz/MCqdOe4sBZ78U/2TMycMW9c+NE8Kj8E4bNHUpLCXE+qYnT8vtAAvzQg8SX2iCTY2WnlS6LgBb21HdZaKIb9VSHHifZ8q6e1s8eqBo3GuEMho6YHBIV0D4xUxiOglJtuw04r74yfCE6fJqftzZ6r0I1+mtyH4s70QePJLO+1SY+Duckf25IIgawWAxohgUq7dKGTLiaVR/FjSP7kSjhI6Y7E4Vfp/nfCS00Z8n/fBNRPoNy4qKFuwIBu0thzaLlOKWjRDTfDEIlx4M1f+8/XoDv12M8Jg3akGC9Kpq9rIJfrb/N4G6tYlkW+JWKt6vvZsY0lp5CNGg/4mXN+7Q57220Hf0hjSaSYJ5YLISHHFG9bGD3IpT92caJQVrLZU33PkVEXetl7F0f5IVBsFO+CF2Y9hl4xFCUHfvJ+M4vcGbFeZF0pWSdaagMJAn8rJTT+LfNbnQoHdBQnvPS5zi5674k+PAg9gWWj8LZThxe733ALAUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(8936002)(4326008)(31696002)(5660300002)(15650500001)(8676002)(316002)(6916009)(86362001)(6486002)(66946007)(66476007)(66556008)(36756003)(478600001)(26005)(53546011)(6512007)(54906003)(2906002)(36916002)(2616005)(6506007)(83380400001)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTVrQ3RWRkNja0crZkFYRnlpQ01lMWllcUlHQWV1VnJEQkV3cy9QZjdsQ3Z2?=
 =?utf-8?B?cFhhTVpRVmQxdDlpVUVLTVY3cTVWamR4cUNQMmd1dlYwNDNVTjlDMys0eG04?=
 =?utf-8?B?V3BaZzdZNGxoajdwTkJTN0VtTmxsc08zSk9UVVhLdnRBdDd5dUQ1NWp3Uk9D?=
 =?utf-8?B?QVhaNEMrVEtnL0ZuQ3VGVXB3RXVmMjd5eU43WmozaUhuWGFKcUxYaW5tVmRG?=
 =?utf-8?B?UVhGNmtDSTdpL2ZNeEdqaGNsK2ZSM2JRTlEwT0M3WkZQMDRmSkhqRGZ5cHY3?=
 =?utf-8?B?OFZibE5jWUQ3MHRqa21MMDhrV05sSFpIdmFHK2FaV3pnMHNpb2tKQVZMUnNP?=
 =?utf-8?B?cVg1dFdTMGxrdlVaMjVQdE9sOXkxWXJMMzhrdGtHLzdlTGZHT1hjWUtRWDRT?=
 =?utf-8?B?QUhLbVRBM3Q1bk9Fam5Wa29RVC9GWFJtcXZoLzl1SGtmaWJQQi83cUVsQ3BC?=
 =?utf-8?B?QndXbTNQQnpqWXNiOEhQVzd6b0Y5eVFtNlB2NTRNV0Z1dng3TndmQndPOXBn?=
 =?utf-8?B?OG8xOStMY3VnWUg3RUxHTjZZKzlFektIYkJEZlF3Tml2eWdQbVliOFBtMEZX?=
 =?utf-8?B?QXBGOFZkTjcxZzZUSzhVMCsxNGVLeC9zL0piRXEzai9RN2NKZGVrRWJEQ3F4?=
 =?utf-8?B?YXFCVmxwU1NyWjVsYVdhNElUNnY5Zit6NUN4WENLOTIzbWsxK0Ruck50NXow?=
 =?utf-8?B?b0l2YitUYk8yaWVuSzhPMmllcW1PUGNvSXRabFFyNnUrYWlPZ2NGeDJpd2ZG?=
 =?utf-8?B?TjVpQktaam4xOXpvZ1NtQ2FZeExDdzhFYlVHS0x3WHo4emZaYUM5QWMvM3dW?=
 =?utf-8?B?RXlEQ1VHcDhmZjd1TS9yb210dWd1enh5b3UvV3BYRFd4NlFoRmMvMXdHeUJ0?=
 =?utf-8?B?UHNYTjNrSWdLRCtsOTI0bXlmQ2ZNcVNRck5xNUw5Tkw3em1Eb1FKTjNlWDRq?=
 =?utf-8?B?T3BnZWlTclRUTFBLR2VqbTZ4TDJYVndTZndNVnY2bmZWNG5RMjVTckYzUE4w?=
 =?utf-8?B?bWxpckdtdjAySlkveTkvNU8xR3l4U3ZPYXNUMEIzYVpBTmpJV2tQMTlvcHRX?=
 =?utf-8?B?VjJUcXJ3RmlQODZVTjYxMjNVbEMxVFhkRk5mY1dBQitHcTUyMnI3NGN1T0I5?=
 =?utf-8?B?ZE51M2lVOXlqWXlqSG0za0ovcHBWK1F2TndkUDBKSXI2SnlFd3l1U1BFcWtB?=
 =?utf-8?B?RUhERXlHYkhOdjM5elg1WTRub3c2cmZPRG56a3NITmJBY2VBSzBLanY2Yy9I?=
 =?utf-8?B?TzFPMkx2d05WNU0zUm9nU2JTS1kycjRMdU5IbVJYak9YaFRTN2F1STkrTzll?=
 =?utf-8?B?N1AzMFBGQmdnZUFKSnRrZzNmeWRZUXNrMlJWR2lIMGlqZ0hDWStoU2JGc2kx?=
 =?utf-8?B?ckkzM0t5T2o4T1FzYWkwcWRUbDBzSDRxb3g4cVdTdDVNaGE1QVR0cmRwL2lr?=
 =?utf-8?B?alNsSnYzbjZzdU5SVDdxeXlKbmwwZmhJaVpjOThYUytIS1crUVVPYitSdExs?=
 =?utf-8?B?YTlhdDBoR2J5dG9hVnlmejZDK1VGODB3d0ZLa3BJUTQ2cWE3MUFkdmVpaWI0?=
 =?utf-8?B?bnNRZnNuRzA3UDdyendDL2tGRk4vdGpENk5RYXN2V3Y5ZVduUkhCMnVVM2tB?=
 =?utf-8?B?a01YcWpmOC9pRjZVbENKM2tQVVV6WWttVHZUWkZ5MWd5MERIcFh2QmdiVWJh?=
 =?utf-8?B?b2Z3V3hJWkIwRlFNZHpMOGw4MFlwSUozV2Q4N1JGWU5ZNloxVFd0OHhHVHpo?=
 =?utf-8?B?ZTl4VWtGelNMK0JkVGQvdGN3cVpoMmJWNG9zY0FMREpzU3duTzlpV3RadExX?=
 =?utf-8?B?SXpidVVIbHN4QTZJbDZ5YjJGV0p1WnZ2R05uK2hkV1NnL204Q1Z0cFlGZW9Z?=
 =?utf-8?B?d244SEF5K0lUeFJOdjVHbWQ0N2ExRUNNNC9hR1M0MkwvVGQyeFNmb1NXTVVt?=
 =?utf-8?B?eXI5MjhNMitKMlExdXc5dTMwU1UvOHdGS2d2NXVHS1Y1ZTNDUXR4eDhvZDFn?=
 =?utf-8?B?bTByaVZPaWVEK1FEbDcycEFQMGxVZWVzaHl0TW1GamEzU3VtMnVtcE9BcTIv?=
 =?utf-8?B?SFhaa3lXRjhVWWphUGJlei81U1dYNFh2N01ITzRBS3g4Y21LK1phUnU2b2ZF?=
 =?utf-8?B?Zkt0TUdQd2oxeTBtRFNjMVloUW9hOXVKUXVxK29mTFpRT2o2QWxPREtwL0cr?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7rfjc5QJQ44POEAlxueMXWCmzUgDxZQkeY/Wd8j3xQE/6xs9FhiyLFnyNSl7fA0oSjYPGv5iAzbqedT/dByXv+VyaWVZ+x53YKwWMevNKwOzBqIZrCv54Nq0vW2OMelyc6rL5pjDF3tnnF5sR3fvGsKLvq4Mo4nRzKhcrquinjz8ytFYONc7qCOwbyQ/EdsMnMo+TVzSmnj0kraURliOt4WpgA4BOBpWmHLAKgAxdg91m3yHEMeyxNVMA9Ei+bii2OSYCeuCNCJtTfaFPk7SnsFAM5HC97zyL3CHItH2cBJt3UZ887g4F9h2JsqUNPP/SJAal4S4aphfqf+vUT7kWI5W6CEs6jf/OCTyhluPMwtiKDi1+1aoUvBVbu4YiLfig262uFJvDIrUddBLb99Iq4loFLE7r08dv+JD54d5AHLEw5tk6/o6sd6mUEe7mbNQcP0fg+nGnTRRH2lTdvE4DwLygU2wv4p/9cccMnK3MWsJbwCf81NSNJtAM5R+GoWC50hPYIYchNzReOKVymHryzubCHBNhBTxYUbewR+r67w/KAMN7Dccj1e5pC0pu7VstesycC9CQuhHEnmVLhHzPPUDwoMh+pHYPSVjw1FAbOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3217d26-2dce-4ce5-bdd0-08dc179b3cb2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:31:08.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCYD2fv+du06MSmBus5UpLccu6N+hKruyU20M7ZHRmbaIKq7iInG86x8XUm17CauG1wubBnHhOLWKkwx1wNGT1Ykkxo+0fJN+YLbxHJK3VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170150
X-Proofpoint-GUID: -mVaedBJlQbPy1Zqhk4eqwwmoMY5V4LP
X-Proofpoint-ORIG-GUID: -mVaedBJlQbPy1Zqhk4eqwwmoMY5V4LP

On 1/16/2024 1:57 PM, Eugenio Perez Martin wrote:
> On Wed, Jan 10, 2024 at 9:40 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> To pass ownership of a live vdpa device to a new process, the user
>> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
>> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
>> mm.  Flush workers in suspend to guarantee that no worker sees the new
>> mm and old VA in between.
> 
> The worker should already be stopped by the end of the suspend ioctl,
> so maybe we can consider this a fix?

Do you mean: the current behavior is a bug, independently of my new use case,
so I should submit this patch as a separate bug fix?  If yes, then will do.

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6304cb0b4770..8734834983cb 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpasim *vdpasim,
>>         kthread_flush_work(work);
>>  }
>>
>> +static void flush_work_fn(struct kthread_work *work) {}
>> +
>> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
>> +{
>> +       struct kthread_work work;
>> +
>> +       kthread_init_work(&work, flush_work_fn);
>> +       kthread_queue_work(vdpasim->worker, &work);
>> +       kthread_flush_work(&work);
> 
> Wouldn't it be better to cancel the work with kthread_cancel_work_sync here?

I believe that does not guarantee that currently executing work completes:

  static bool __kthread_cancel_work_sync()
    if (worker->current_work != work)
        goto out_fast;

- Steve

>> +}
>> +
>>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>>  {
>>         return container_of(vdpa, struct vdpasim, vdpa);
>> @@ -512,6 +523,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>>         vdpasim->running = false;
>>         mutex_unlock(&vdpasim->mutex);
>>
>> +       vdpasim_flush_work(vdpasim);
>> +
>>         return 0;
>>  }
>>
>> --
>> 2.39.3
>>
> 

