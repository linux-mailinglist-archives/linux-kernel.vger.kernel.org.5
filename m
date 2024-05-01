Return-Path: <linux-kernel+bounces-165316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD38B8B25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204B31F236F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984412E1D5;
	Wed,  1 May 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="okASTvmz"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A112AAE9;
	Wed,  1 May 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569909; cv=none; b=Ym1EERuR9BcBfPJbj9BaBzrrlEJNVtG0H8TJETKmh3CAbLd5h2s9qts7gVyV3SuHlZUEafdkKG9u9UHyRWhX76x+jiq4NMzVMc5XT5BYj3fbF2ObzcCa7A3haBfyYCcpkVQA21jJqDdaVPBHluHZ+uo/BgAl4Sun32GEPxu/IdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569909; c=relaxed/simple;
	bh=aksnr4wZvTiKHL/wBxAa90/6rY1Vkk1YNhSPf2e2zII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd5Lj/4YyM8eg3ppk893UOgWenWee9FTcQnRASWHFX1PsoPErsacIJsiQkvz8P6VH2LF2OGfRqmySgucEkMQQu8xYEFZnQ/ssoNV/m/CpF8QPchODxyNYY33RatmC77XOSHR3q3ntJp9dF7N+D3M0GQ8YtYQfcnxUpnD6i5HKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=okASTvmz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441D1P6w032152;
	Wed, 1 May 2024 13:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VtTRdkGdvGrfK9WTKeeOLVW1BZ/Jx2UHHzC7ZIhvOdU=;
 b=okASTvmz3JMXEGfrDiqKsb0WMCk2ZPy3ASNJB97kzWzdadcUN3czVG8W4Kr5D44szerw
 YSbH4rxjFsLb9MwrTps+awMwo8q1ax4yxwj6EYKJ9xBz24guyT4+vkqrRftg/Y8v0g8i
 Z+VRvH/BrXISEFo8WwkAqQtbQl138+jZXuq8TVVdlsZjB+9j8EP7dd98JcpLi5pDLJ1S
 OVEGSGKcVjpeOpf0NozfThkg72+se5iOljmtR2/Lsm1TUmxrzCNaSA0IHppqW6wpOKaR
 GJB67YiaWZLtCxXw1Nrnl53bhH9yT+U8d7HUAxmw+YV56xIFDJ9193cOTaf9M2yZzRqB JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xundb85pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 13:24:14 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441DODXx002075;
	Wed, 1 May 2024 13:24:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xundb85pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 13:24:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 441AKOWP011742;
	Wed, 1 May 2024 13:24:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsdwmabv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 13:24:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 441DO9K248628142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 May 2024 13:24:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B5C62004B;
	Wed,  1 May 2024 13:24:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38AA120043;
	Wed,  1 May 2024 13:24:08 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.19.120])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  1 May 2024 13:24:08 +0000 (GMT)
Date: Wed, 1 May 2024 15:24:06 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
        Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Message-ID: <ZjJCdodEf4CBa1N7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240426190253.541419-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426190253.541419-1-zi.yan@sent.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HpBxHsoDoM_cYrSuaUG-FjR1SsRDpgKU
X-Proofpoint-ORIG-GUID: W0Ht5FXMxefL5AvciKQ2IdHSC6ODgitg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010092

On Fri, Apr 26, 2024 at 03:02:53PM -0400, Zi Yan wrote:

Hi Zi,

It increasingly looks like this commit is crashing on s390 since
2024-04-30 in linux-next. If I do not miss something - since it
was included in mm-everything.

> @@ -1553,9 +1558,10 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>  		 * page of the folio is unmapped and at least one page
>  		 * is still mapped.
>  		 */
> -		if (folio_test_large(folio) && folio_test_anon(folio))
> -			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
> -				deferred_split_folio(folio);
> +		if (folio_test_anon(folio) &&
> +		    list_empty(&folio->_deferred_list) &&

An attempt to reference folio->_deferred_list causes the crash below.

> +		    partially_mapped)
> +			deferred_split_folio(folio);
>  	}
>  
>  	/*

[  507.227423] Unable to handle kernel pointer dereference in virtual kernel address space
[  507.227432] Failing address: 000001d689000000 TEID: 000001d689000803
[  507.227435] Fault in home space mode while using kernel ASCE.
[  507.227439] AS:0000000180788007 R3:00000001fe2cc007 S:0000000000000020 
[  507.227492] Oops: 0010 ilc:3 [#1] SMP 
[  507.227497] Modules linked in: vmur(E) kvm(E) algif_hash(E) af_alg(E) binfmt_misc(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) nf_tables(E) nfnetlink(E) dm_service_time(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) loop(E) configfs(E) lcs(E) ctcm(E) fsm(E) zfcp(E) scsi_transport_fc(E) ghash_s390(E) prng(E) chacha_s390(E) libchacha(E) aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha512_s390(E) sha256_s390(E) sha1_s390(E) sha_common(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) pkey(E) zcrypt(E) rng_core(E) dm_multipath(E) autofs4(E)
[  507.227546] Unloaded tainted modules: dcssblk(E):2 [last unloaded: dcssblk(E)]
[  507.230569] CPU: 0 PID: 36783 Comm: pahole Tainted: G            E      6.9.0-20240430.rc6.git237.d04466706db5.300.fc39.s390x+next #1
[  507.230574] Hardware name: IBM 3931 A01 703 (z/VM 7.3.0)
[  507.230576] Krnl PSW : 0704f00180000000 0000025e1092a430 (folio_remove_rmap_ptes+0xe0/0x140)
[  507.230588]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[  507.230592] Krnl GPRS: ffffffffffffe377 0000000000000000 0000025e122075b8 0000000000000000
[  507.230595]            ffffffffffffffff 0000025d8f613288 8800000000000000 00000157a38b8700
[  507.230598]            000000023fffe13f 0000000000000000 000001579ccd75c0 000001d688ffff80
[  507.230602]            000003ffb9cacf98 000001d688ffff80 0000025e1092a428 000001de11fab878
[  507.230610] Krnl Code: 0000025e1092a422: c0e500039f47        brasl   %r14,0000025e1099e2b0
[  507.230610]            0000025e1092a428: 9101b01f            tm      31(%r11),1
[  507.230610]           #0000025e1092a42c: a784ffb9            brc     8,0000025e1092a39e
[  507.230610]           >0000025e1092a430: e340b0900004        lg      %r4,144(%r11)
[  507.230610]            0000025e1092a436: 4150b090            la      %r5,144(%r11)
[  507.230610]            0000025e1092a43a: ec45ffb26064        cgrj    %r4,%r5,6,0000025e1092a39e
[  507.230610]            0000025e1092a440: a7910001            tmll    %r9,1
[  507.230610]            0000025e1092a444: a784ffad            brc     8,0000025e1092a39e
[  507.230672] Call Trace:
[  507.230678]  [<0000025e1092a430>] folio_remove_rmap_ptes+0xe0/0x140 
[  507.230682] ([<0000025e1092a428>] folio_remove_rmap_ptes+0xd8/0x140)
[  507.230685]  [<0000025e1090d76a>] zap_present_ptes.isra.0+0x222/0x918 
[  507.230689]  [<0000025e1090e008>] zap_pte_range+0x1a8/0x4e8 
[  507.230692]  [<0000025e1090e58c>] zap_p4d_range+0x244/0x480 
[  507.230695]  [<0000025e1090eb22>] unmap_page_range+0xea/0x2c0 
[  507.230698]  [<0000025e1090ed92>] unmap_single_vma.isra.0+0x9a/0xf0 
[  507.230701]  [<0000025e1090ee9e>] unmap_vmas+0xb6/0x1a0 
[  507.230705]  [<0000025e1091e0d4>] exit_mmap+0xc4/0x3d0 
[  507.230709]  [<0000025e10675c64>] __mmput+0x54/0x150 
[  507.230714]  [<0000025e1067f3ba>] exit_mm+0xca/0x138 
[  507.230717]  [<0000025e1067f690>] do_exit+0x268/0x520 
[  507.230721]  [<0000025e1067fb38>] do_group_exit+0x40/0xb8 
[  507.230725]  [<0000025e1067fc0e>] __s390x_sys_exit_group+0x2e/0x30 
[  507.230729]  [<0000025e1136ba4e>] __do_syscall+0x216/0x2d0 
[  507.230736]  [<0000025e1137c848>] system_call+0x70/0x98
[  507.230780] Last Breaking-Event-Address:
[  507.230783]  [<0000025e1099e32a>] __lruvec_stat_mod_folio+0x7a/0xb0
[  507.230789] Kernel panic - not syncing: Fatal exception: panic_on_oops
00: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000025E 10630B56

Thanks!

