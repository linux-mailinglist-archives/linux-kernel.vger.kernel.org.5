Return-Path: <linux-kernel+bounces-155645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0928AF527
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9531B281560
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ADB13D53A;
	Tue, 23 Apr 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJeAqdnb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCXZlxe8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0044CB55
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892308; cv=fail; b=ciBtwmqynW+p3HQliHwa2vFnSNzekUHwnHVjgyUMzfkb4pErP/f2UqiaPVZqQnqx29ElBeWVCd+LHzvjCghOferMkWmoKGLSMSsGn6x3DwujC1UP+aXjzkeSbw7KN+ved51f1wzWS8kqp7jJXGqvDrh435Nw0SjQBocPupdZ73Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892308; c=relaxed/simple;
	bh=1GV/k2wbRiFR/WKzVkzL5Tks2O+2kiFNKHUTs/rP6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klyIqu/k0vxQXvCZBicXjwvqfTaVuYU8CpfZEAK9lLEGldi3H8EFMwu54YPASWzqoPIdhJVbd1Q7iiZE1YMc094MRJcpIEPeeH/RSI+PoQsSdzchExQkgsPPw5zXmsl++ZhnMFLi/IjChdi3sM1XNJX7TDWw/jWixUfp1glkLLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TJeAqdnb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCXZlxe8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUO80006565;
	Tue, 23 Apr 2024 17:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ywLgK9nC5tf68i6cXx6xCm4XMmLLsA2sBHiDY5Y4/Lc=;
 b=TJeAqdnbXsCNKH2S+1q7c8piq/ZYJs85/rZW8dt0xLeel8dC9c/rZbysoKfu956yupcI
 7S65NQyQzU+VbZ/L9EnLilk9Mgxnz6WbdMLD+LukqYKB5VnEg+YDQmTGKQAJeCI5umfN
 /M5hSRauxSQc+cqE6lSga1iPNhRBhTn5f1zYhIifZ4QfAm5RPhsKdHbqJ4/J96LzoYxR
 Ev/QHz9KGdjAq/PO6bBh4wAbtTZzCS9JIraH3JDYWn0AVgZtpe4NmzQsEorJIDqpIvPk
 gYI49p2vsObuJX1n6NMv04YzjXhohJxEifVXVqKvKQwLI+nxvhZC1dI4wf2L8NT+Tr1r lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md6khf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:11:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NGM02T025273;
	Tue, 23 Apr 2024 17:11:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45dujfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3xwFEm/e3CaC1Y0a7xydMXjsY8GUuzwPij12H1tcfTZ8eDGk12HsyA8ff7Fuynl2TtDTXuCuax4XGpfNtIgEghlbQBzjpD3LeyNSlZc7yzlACLxbcOFOI1r0vcgxrR0nPlHxmTdWJRpxc4Q6iuozfLEbmvaKLwQQ7lPA1NiUVGpjhUT50gvxbIPh2P+TD1uEW84AYfD1ND00HTVRZaKtaQ1Dz6DxEU6EsDECfaV26VJo1B/EHrZq8fJUo321BrjMn4z+8VaTVrvCpDOLEQRWudWM8b5Tdue84DdC1kEHJ03+SD8IL+rdxHHoU0mu4SvP2BTbnBGiG0+aBgZ+qVkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywLgK9nC5tf68i6cXx6xCm4XMmLLsA2sBHiDY5Y4/Lc=;
 b=H2ulBteJKfCLWJRDHZyUHpn3yL0y1S6fE0srKMs+Mo4ugwqwQLjn5N565SifL177ZEuel1QHLOc/RAaX80wvfi15iRjUsdU0WCtjkxLppCXB6MJGW1ctdeCQPFXRPsIPpytiKVc/g7QjoVVdHTAjbs/Dy6nOD8zixkJ1xABRn6lOdh6awhwBlcVdcz0/jpPvl4n0Kn5CKr7MKJmafC2B3xMW0YERyBwB6DyBfSXNA64WmVQKWEyHUOG+6qVLVa0DncZqJVAKqzsdOQbsm80nTvfHD0bnotx2JXlQX/rpbyOjqPmno0wA/2026EpRwzSuEIIPOP3JCkZYiZH/4bgJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywLgK9nC5tf68i6cXx6xCm4XMmLLsA2sBHiDY5Y4/Lc=;
 b=cCXZlxe8Nvl9s37tJXDZv+C1go2A4jLAe3zch5DjwqGL3M4dCDdwM2P8BMntNeluYEqHabcGvf4uCPkylmgI2auWgDUolvRbPE/4IdAKDEIpc2AYg6BD57gTVEuBjY+aKWnE0pNJhkbLYRlF+eAO93BvbkY2MCueNKfAB1llpsg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:11:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 17:11:31 +0000
Date: Tue, 23 Apr 2024 13:11:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: remove unnecessary page_table_lock
Message-ID: <3v6xmyzmnw6go45riwlu7qv4c4phiexpqxldnlbgwsjhppe4oi@xdcqm4xupl4k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yajun Deng <yajun.deng@linux.dev>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240422105212.1485788-1-yajun.deng@linux.dev>
 <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
 <3c452d5db5b3d5879160ab62a9e0ac4481a6298a@linux.dev>
 <fd7fde90-21ea-4617-be17-ba387b44feaf@redhat.com>
 <b6ea1fb5bc6c06d2855e41b4034656b0a76b58f5@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ea1fb5bc6c06d2855e41b4034656b0a76b58f5@linux.dev>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f9c37c-574e-484f-5cce-08dc63b86bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3V0HXZe6pI0Pvbbjg8DcZgM+qbj4f3L2JdpIVaycy/RgGKovYpqRZBdgSfRX?=
 =?us-ascii?Q?Ezmfy4HHMIzwF4JDJLXjSEQ8bM2D8uyU0dEH7l/uWKfcUx4D5+R5cvmIEyIM?=
 =?us-ascii?Q?g9+ri08mPfga1/ExzVR0KO2KIsFrkDjNvzb96y8BHfQNSRbXcpuyOfXFyFhr?=
 =?us-ascii?Q?jl7KutNo2iRI/oNmJaZjItmOSHpIffNzwJOfstvkjNvZQFxF/fGD5KEWZW/a?=
 =?us-ascii?Q?pwXS2tmozO3DlNb8j4rlBPND9gIgqEmy8qKnoN65F38mhxigumN2ktGVC89U?=
 =?us-ascii?Q?gwdsC+4Wnde3GRP0ruZuIwJURgCEMG+8rp6nm6ocKqD8PNiN/MMID+qZPKZO?=
 =?us-ascii?Q?YDYH2hOHoXtnRfzfj0qdjx0g3Xj3wc4KajTBzl6pE+jsudJKUAApJfwfNOQD?=
 =?us-ascii?Q?X4RdYMSDcrYgtHUx1N8Vk8FiSYD7vDMDLAdQg0qYUtOXGiKhqEjeXYLQTRuk?=
 =?us-ascii?Q?ayM6Xrwm+/InId0PwbdGAygSyW6bureNp70eTfRwiAD/P2oF/8cagFPI3Daz?=
 =?us-ascii?Q?7vGtcPMhueJOC6TiDStuSGXjNtVmAmL3+G/ngLWoKXe+GLEhxyFRMCOspsbo?=
 =?us-ascii?Q?RjhIUiH+dMuMon5Di+e0JdFFeXqN3zpOyTHiBbTlyptKPXBRILMasrTOz213?=
 =?us-ascii?Q?F7xN9rCljo8h2/LyQsJZf+bSFa0IpDosh+EGLUVBfi+4mF21UGMh7PJ21AgH?=
 =?us-ascii?Q?ZpDi98+k7zk5QSRkX6E1birIF5vIfjQ0ZtnJyzqSpm9J1AcdT616ePqu4kGB?=
 =?us-ascii?Q?yZw4TqFgDx0EIoX51g+RjEBL0VDcAnSZlEWLmwN8aFbCx2CXYwoVYQLbeIci?=
 =?us-ascii?Q?5ZKqntDNbyVjyUmnAzTgRIWPMK7dsQGyeyTXQn0J5hnCFlB5Ja0cyw1kZAQI?=
 =?us-ascii?Q?g95aupJJOs+kZ4JU9RRuMM/RVuwXCrwyBH/0rv9svZUC8B+PlE33+juLeQLu?=
 =?us-ascii?Q?9LUrWHCREftmYWji0i08asvNTTNKvlipQ8tMCiudz0gOcYlno4UUEgdC+p+2?=
 =?us-ascii?Q?0yLsI4aKSA/Qqj6IIcjiNRG8ckaecPR7RIJdS/kvD8pWvWi/CwHo5GGrxpfp?=
 =?us-ascii?Q?EV5OiXM91wdvsNC5RgON+z4ZqReDahcK7hLHjd+XTShnKbErCkRIiJKw1Zak?=
 =?us-ascii?Q?GSNlqlkRXEcd6E0ibUT+ysn4ASrpbKCl2hp6ri2+y/dzc0FeYGyyk1MYVoMD?=
 =?us-ascii?Q?saXjBES2+uT9zxmzdl2qO7CykVPG6Yi0VYWqydd9heKQC7PRebM+m3TZs+Ok?=
 =?us-ascii?Q?x+YEC0mAnL19POY39QsBs5bDXfQE+iHQdkM1Rn5vSg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kEw6UagGWIalBTrmCvG36eHxHlV184U0qs6zO5y7d6z/tlTWroSVsPNpwprt?=
 =?us-ascii?Q?HT97qQvEdXThChvrAJdMiNmad9KvVTSGK5SOf4Kx2KaOW3sIv8EW31hFgS6K?=
 =?us-ascii?Q?QEtHBmpvrgkeC6bbyVPu8JXA3Gk+2NeuN9rk6xSbCbZg06bVZtKeH1q7RXWa?=
 =?us-ascii?Q?vwKK663aJFtB6BsWwmlwd61HIufA8Pv3167PPo/9INWhshGtJoxEB8SDW6uM?=
 =?us-ascii?Q?PrtwJJHaMEWjQ8KvSsIkeJTY0/LjCPsMwEf2Zh1eT8NGr96ncMs4zRDc+vMa?=
 =?us-ascii?Q?mYN8yyYLlsJVCg1v1MvzRMAuvMSwa1zabEcf7iSSkMSOCIBZYwkEmRrZgIcx?=
 =?us-ascii?Q?3zv5PMBeTYkPEm9TdOegn7mfttDapiuJjHOcFEPem5X3SM4cf2Hh0Sk7Kbdo?=
 =?us-ascii?Q?TMM0BmenoInbwY+CbkhfkYftreA95Aqg/xm9wFGck3vg514X8pr0KChhTFch?=
 =?us-ascii?Q?tn8qM33Utp5u4fpBQE6xhV3bvGACDjYxugELGPSRlEu4+xEjg2eGOz9H/HIh?=
 =?us-ascii?Q?aUCIFSdTss29/H7HrjgPptlb8jD25ono3Z5TzMxGRuTUdBZqlp7G4SStz7d3?=
 =?us-ascii?Q?cub+5QSH0Monf8URQ/jQrhML9v7RPA32CjzBFAiuPu5Hk3uh2mdl9hH5+H65?=
 =?us-ascii?Q?w0kIV5XxdeCpa8oIdX6u7NoZS9vARmdZgvmgErZkCUkAZxk9ct7oerJ+lI+K?=
 =?us-ascii?Q?0twXcYXEmel8DNB6VsPdmq+pY9MKXZkiL2Te5kLe4GuB5vqOb0GdOpOe+pR5?=
 =?us-ascii?Q?t9xxCu0cu0hgfYUT1uJzt+OspOqsHE0eLxqA7OkhBxFOvD6++mufBMwD/9wv?=
 =?us-ascii?Q?5DtwlrpEEqTgkgMTrRJivF2KR9I15mzKiA42FyozUVeAq2VmDUx/even9TZ+?=
 =?us-ascii?Q?PuMaqgyU+iqupBWDMRIAeWWUSTyTtgNGZPURUcGLn1UGId+zmMxSRBKmreoK?=
 =?us-ascii?Q?hehvrTJCn2fwausn5mks4H2S7jrBfp1faH5lsTgmCu2oZy0V3fExFOCoEJ5h?=
 =?us-ascii?Q?clhS/8S+gDDGLt2oM/MOnclKt19v4vRvA9a2Ef0eAVRy//QuVyc1A+nXcYon?=
 =?us-ascii?Q?QSso/Bs4iiskWmW7JPQUII+Ua61fhHAByZcEBFYG0OkS0Wqq7g+cxaTuY17s?=
 =?us-ascii?Q?pjOGlqFcFEuHMpg5XJFDVh+XoNPbexIgu20GooVybtqOjic2wuEwuKtvwD7E?=
 =?us-ascii?Q?9Hx9q2GdOzD2kk1ASi10uhOAdS8Xn2ckxUgh6EuQAboOAEoAthjq4AdNQYVk?=
 =?us-ascii?Q?UNWrA5aWVUgdcSBi+pLWUfCQuxfOF6nDQVedHnfvYiAjerv5eLQ+rtjBVxs9?=
 =?us-ascii?Q?18VkWasf5z4YLVui6/F/4PFC+y/02V3/anDZV/BxTzDBi3LoR3OYbZUBq+UL?=
 =?us-ascii?Q?9PMUDH+TG4hFTD+KpmHqwk7BmGba2wI1dAdYyHAHUcybtk0lTlJ7lLupCbFY?=
 =?us-ascii?Q?eY4rBlpWUgVxTFljZoaWNRrnE8MQxLB326tpHR1Fh/gX3tK+X/toXZL/h5pn?=
 =?us-ascii?Q?ajpNaomD8EswNVGSz2FUId7BMKUh8k314h9QOcBfacTMCIl5W1QSYTHqrd4x?=
 =?us-ascii?Q?R5zp3zHnh6IXT+M8lA/3lTTaTeB09D61+PqS+1Ft?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Chu8H9OKnwQKDYXUmifH2hWvNUsWwhPI9EGiEl1B7Jkm9poFaqjKyVX5GrKUneTJ+OE3ROuHOeOM5S4MaMC+gJphO5/bf4xEi376StFToPoSV+aUE5sguNRes91bkj8CmC0gbUMtRiINtFRakx2mhNnit9ek/V7YPlNPwUYNbAeKw2UdbIiLH2SaeoCYabZTvp8D3hNWVPm5ab7cC/WasEzsMu5+XSI04WqkTNwsw86Ylp8HpcUJ2Tsx/dk7/X3Pv2TI1OGKt+mPAJFYRpkx2zhuUYB4J66MuSId8MgOA8DTzTT62oIlqgq0edz5CnhLd/YyDaXlBhX9HjiDXMp19FOBSTIFrY2vhB6m796ymY6HG9ZZxVAYyBXtdreXVv8XfsJoHAlajGu5TIZRaQilvreNMzlyTkX1w+aQrvTELdUMUzInC7UbvqwmMjnvVQD6aKhp2UfBOt79hQECFwcg38TmxYqcFjgVhXRnYl+mR695Jyjk0UuF/AB4/iyo8H/uHSjonZiINOStvZZ7gPI8d5LyWN1/HEEiE9osJ5EWPBMzA16/QAsz7GEi1ySwdd32eO1i63HFrKh7Bcs81hrwt1aZbj8JICo/03hRknpy1cY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f9c37c-574e-484f-5cce-08dc63b86bbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:11:31.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI7YcEw8Qm1A1eT/OBp2Ee/RxMvyqbg1NrR3jeJjJlE9hhrIYOC7uTFfoKPYXWS5puTgbiOC5sVHnjiWuh777Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230039
X-Proofpoint-ORIG-GUID: eJOTqgqxq4T91lLC4dvKtOdzoP5aKEbU
X-Proofpoint-GUID: eJOTqgqxq4T91lLC4dvKtOdzoP5aKEbU

* Yajun Deng <yajun.deng@linux.dev> [240423 04:35]:
> April 23, 2024 at 4:18 PM, "David Hildenbrand" <david@redhat.com> wrote:
> 
> 
> 
> > 
> > On 23.04.24 09:53, Yajun Deng wrote:
> > 
> > > 
> > > April 22, 2024 at 7:24 PM, "David Hildenbrand" <david@redhat.com> wrote:
> > > 
> > >  > >>
> > > 
> > > > 
> > > > On 22.04.24 12:52, Yajun Deng wrote:
> > > > 
> > > 
> > >  page_table_lock is a lock that for page table, we won't change page
> > > 
> > >  table in __anon_vma_prepare(). As we can see, it works well in
> > > 
> > >  anon_vma_clone(). They do the same operation.
> > > 
> > > > 
> > > > We are reusing mm->page_table_lock to serialize, not the *actual* low-level page table locks that really protect PTEs.
> > > > 
> > > >  With that locking gone, there would be nothing protection vma->anon_vma.
> > > > 
> > > >  Note that anon_vma_clone() is likely called with the mmap_lock held in write mode, which is not the case for __anon_vma_prepare() ...
> > > > 
> > > 
> > >  Yes, anon_vma_clone() is called with the mmap_lock held. I added mmap_assert_write_locked(dst->vm_mm) to prove it.
> > > 
> > >  I added mmap_assert_write_locked(vma->vm_mm) in __anon_vma_prepare() at the same time, it shows __anon_vma_prepare()
> > > 
> > >  is also called with the mmap_lock held too.
> > > 
> > 
> > Make sure you actually have lockdep built in and enabled.
> > 
> 
> This is my config.
> CONFIG_LOCKDEP=n
> CONFIG_DEBUG_VM=y
> 
> I did another test.
> I put mmap_assert_write_locked(mm) before 'set_bit(MMF_OOM_SKIP, &mm->flags)' in mmap.c, it's outside the lock.
> It will crash when on boot. I think mmap_assert_write_locked() works.

If you are changing locks, then please test with lockdep on.

> 
> 
> > __anon_vma_prepare() is for example called from do_anonymous_page() where we might only hold the mmap_lock in read mode (or not at all IIRC with VMA in read mode).

Consider two concurrent readers getting to this function with the same
vma.  There is no mergeable anon vma, so both create a new anon_vma.

You take the anon_vma lock to parallelize the linking to the vma - but
they are different locks because they are both new anon_vma structs
allocated by concurrent readers.

You now need a lock that you know cannot allow this to happen. Looking
at the top of mm/rmap.c and see which one works.  The next in line is
the page table lock, so that one is used here.

What if we reverse the locks?  We can deadlock.

What if we don't take the anon_vma lock?  We can have two writers to the
anon_vma.

Thanks,
Liam

