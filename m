Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32367599EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGSPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjGSPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:37:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC57BE;
        Wed, 19 Jul 2023 08:37:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOh5Q025917;
        Wed, 19 Jul 2023 15:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OQXR4oOdFVwzUkI+CH9qzKtj/QSDTLLjPpdrXgrb5DY=;
 b=EG8F/d/2bcD2F3d12pUEDcDMrbrCeMIwr10+5Nsye7f3XzbsP7RL67aLKln25RqEl0sn
 o5YL1Pz/glCK4JgQLfuJKe+mhlhv5LE1/EoiUe99Vsh6Erzd4GWj6BGdNcwRMNCcRXk6
 qJ/E5QmTTiUDdRhLbjOQLtLzMGGz9PX8BjmT/fBNLyVLtsFo+Iq9D8EWET1tDBIQog02
 z2mEGlkONBbQlHUQJ39sTnqlznKJkgLxKlAb/2YoHJQcgXb6WpSMpGmG3h7uDmU+i1S9
 QxCcULCwrY57N8wJao5vmBaDwn0rBUqbvQLF/cYHv01f0lO+RLJHtK+SyeVcxlVmHGws mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76yu15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 15:36:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFKYn6019372;
        Wed, 19 Jul 2023 15:36:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7h3p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 15:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8lzBBzCe9gUj5g8OPj1lWVnNIi3AjJvwnlzl1pYFbQFRW1cXpdAm2kaV/4qsGLOLzsaetJZHzNYn3el4xBwasi71OXN7/b26XOCF2Gxq1ZN2xwWpvXZ5xKmdglu5O1aQE52k8/zLtxn3HoOIneUBEfUaGgNqlmaW6m3OWXcha4l6X6MgndNcCR6lGhFBpIDp+8zA/eSyA7nKWFZWTJx0M8oAIMBiCcJi/dsGMHEzVfB7qG8mLNTYwah8DGwEI1ZmQcrkGJ3Q4mtZCAG0p9J+ks95M/vWmVoKIK1G4h2Fv2qe8Y3sgZ7itVaYnreYHFbQRi6kPnmDFGA6aNx4TOybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQXR4oOdFVwzUkI+CH9qzKtj/QSDTLLjPpdrXgrb5DY=;
 b=OIEExcHKBqbmuHMfdVbun6ztOt5c9YLpD84D2X4o2TwSRGFGCRibegY0XjDHjaK28aNUe7jMFmtEBa74TmtC6H4iO5P+kbtoiO5PV8ZuNF2JShpf31PKYwHoF6xFsFqG7gMkRhbcknWt2e1KoVvXKjtOnYSEu4psgEPuWRDY25ujrCTD1HoBk6k+wKyY/KTBfWoeMgCJQ23CWKyn9KZGseUpZNsxB8dgY2w8ccieU85pKw8jB2jpyGcyDG2ne1dNT3Ke2Gzwg4EFjS8JOBQY4r9WLwCBb0QroJYJKcl4OHJCXTcWUC9fV2gVBINErh6ioo1g3zZhGWYmnikv1EO85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQXR4oOdFVwzUkI+CH9qzKtj/QSDTLLjPpdrXgrb5DY=;
 b=cnW6FVLrBVhdKIgQ8ssjlmi2iYcAzLhGXDrVkEPPMezMtKoPdlbJcGatH9OURIsjyu4IFDEv+N4+rDdRtEvZFanjQCTlmLGqupQ6o2no0tMiOsJZxL/Ntdr/dkEa2yJtxB1h8Adzj2fIdVUawnMUD37o1ulxSZHos2N80oudy1M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 15:36:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 15:36:56 +0000
Message-ID: <a5082f3b-58a4-0773-2608-2e2647459d3c@oracle.com>
Date:   Wed, 19 Jul 2023 16:36:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     Ian Rogers <irogers@google.com>
Cc:     namhyung@kernel.org, acme@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com>
 <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
 <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
 <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
 <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com>
 <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
 <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com>
 <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
 <4f0355ec-8bc6-e51a-ab5b-61d555a68b6c@oracle.com>
 <CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 319c8ca1-d564-4014-006e-08db886dfbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/Fx9PSysyCrIJI4tlv7y4lmp28bVUbxA/fdZx5WAmBpzbOTexkveSCSSyIuZV0dYvWTRcQoi+L0RJt3bvItRQMNaSTrVLHAWC7m/hclDrF51OgGvoqkxjnLCjCIVenHt35zf/JpMyUUNY/NNwRgvUSoA/MrTtk4YzxualbeXnN5hN2LXA1SUjfV4O4SRIGtNv6KFYtA65yddmdWdZMMXuhVX80w+DAE4+yHAKKu7hswBy8Mw8LU022jYEui10Tm7nGT1siuOyZXjRZk9Cu5IHBKG/BxwVTvPTHTFXWWMe60ulrGdVol39acN5sJhTKLgzedkefmtBiOoD9j/ie9sT1hbYs2ocBKhO9xjRiKIdQ+ni71KAe97GdKsNesazAWP6Y69ppkC5gnl0RbuJM+1GJyLdABAQ3g6Jy+17nwcqHaTgxoptd59FtrSYOWzNDEqCrYNgud2hr1E61qBdSaS4xRSwPK9TQTeoltYB4E8wI9HX8OcdC+c5mGJO8jNDUk8j3AlwcQwEjOoX5BinZ8HNOZWYwMfh6UaqbGaa1K0xq4zn+OEhgJsGvPGBFcNNypq3mJPKzR+SM3XpmISRRk+tLN8OqlfX/WstZ5OIJSbwtKvlclSvi5lc9xqHd1781FpSouoJoA5kKBKcE3jB3z+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(36756003)(31696002)(86362001)(31686004)(2906002)(36916002)(478600001)(38100700002)(2616005)(26005)(186003)(53546011)(6506007)(41300700001)(5660300002)(8676002)(7416002)(8936002)(6666004)(6512007)(6486002)(966005)(66476007)(66946007)(66556008)(4326008)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05qelhFa0RXKy96UHM3d25ESmszWFIxR0dYZW9PNnFGb3YyZHBiR2ZpUTRw?=
 =?utf-8?B?MjF5ZjlaSWx0OW1NelZ6ZFdjU3huSDNpMmh1a1B2SDJrZlovM0w5SnZKaThu?=
 =?utf-8?B?Vmc3Vnl5Z3RoMllTekJoc3N4WmE1cENEV0hWL2c5bSt4VUxCN0NvOW1HSDdN?=
 =?utf-8?B?UEJqT250UGxweUJMYWRzQjBCdmxmUnBtRTRCWjZKWFBtRGwvTDZYSmppb1Zl?=
 =?utf-8?B?Zi9mSzAxVkI1Mlk1aTBlQjNLd0JvKzlncEtyTmpRYkxSN3ZIOHE3akdldGdU?=
 =?utf-8?B?eGo5UFNyRlo1SnIwUnVHRUhSRFV6eHhCc2RlcTBpSlcxY0xCTGV5RWMrblhX?=
 =?utf-8?B?ektSSENyc29jczltaUhObUw2aGNGOVZIZGx1c2ZJamhNMzZ6ZGhuT1pFK3hv?=
 =?utf-8?B?TEFrSEdzcVZ6NCtvQjdVZmNMaEN6YTVQWjN1eVg3UGlacDRYeDJUUGNsbnJW?=
 =?utf-8?B?enBjNXNyU0IyazZ3TkFTVWxGQmZqK1lMNGgrTmVkTVVpUFFxNS9ySXAvOTMv?=
 =?utf-8?B?UXhlLzkzalgxK1loVitsVGFUWUhOc3l6SVdjYVZWRWV0eFkzRHZVYnNPbDNl?=
 =?utf-8?B?VzZ0NGRVZnhJVDNESnB1aVZnR2J2d0tNWFdvOGFleUtPK1FLcDBPeG5HMkFQ?=
 =?utf-8?B?UURvbW8xQ3B0OXl4bzRESVZCbUZYNklTcnhKTTZpSGxqNzdsQVkyVER4ZWxo?=
 =?utf-8?B?ZjZsZjZ3T1ZoQU53ODRpelFMM3E4cXdEaVQ5RFd5WXpXUzdLTm82eExHMk1N?=
 =?utf-8?B?cFN4VU5FeTlDb1lhSnZVNkwzT3k2R3M2ZVpSdnlPdXk3OG9lY1dUejRCUmF6?=
 =?utf-8?B?NTJqT3FPeWdGeDZPalVIQ2Y2MW1URzVFamhiOWM0RDV6UERYcE96UDh0WDhl?=
 =?utf-8?B?WDhVY3R0QnNQTTRGeVozM0h0Vm9YSFp1ajMwR0VlVCtKOWdNMG1wOVNSakNi?=
 =?utf-8?B?ZXBTK1R4NVhYemtySFJRYmFidEVwWEhDKy9Oait2M3JLTlpWdkV4VWJIK2Zs?=
 =?utf-8?B?UHVMSnV4NVRJMmRHcUJDKzRhSTJqcFlPc0svdEloeldDeCtUb2xhcGdpb3JV?=
 =?utf-8?B?TzFjUkwvWU5tMWd6cFpFYW5VcFcrMVhGNmsyWUJWN2dZd0NmV2tJN3o1SGND?=
 =?utf-8?B?SzBxc3lmRWlHcllwOFZhem5tNDhNQkdjbGdXcG0zWEt1LzVaNXhJZUxPUEFr?=
 =?utf-8?B?dUYvSWI3eWwySmpqcVJkcStoa2lKOFg2cndlN05rbkpRdkh2bFFyMjhDbGY0?=
 =?utf-8?B?MUdUMHMyZ0JpNFM4N3djUC9ka21iMTBIeDhDZVFGc2tqVUM0Nmx5M0JDSlV5?=
 =?utf-8?B?RzF5UlFTaXF5anAvZWVKOU92ZGQ1UHh6b3Jnc2FLeDh1R1ErMmJnNEhnVEY5?=
 =?utf-8?B?Yy9SUGZ6eldYYW8xZE1aSXplN01FK0JObTgyN0xYSWhQb3dMM2dGMUpRY1Zx?=
 =?utf-8?B?LzZBckQ5cWUwMHo5ZG9ZUkVoeXBtT2h4dlJQUWhxWnRyOU5jREZTZENFMmJ4?=
 =?utf-8?B?T3YvZjB0eW96cW5ZZHB3L1EzZU80alVnNGZHa3RLb1orMjRBNHlHZ1RvZ2dL?=
 =?utf-8?B?dkF0RWtSQ2xOMERva21rSjd3SkZmOXZlMVlvTHZOQy9YUjA0b1ZROWpoMS8z?=
 =?utf-8?B?R2pUSDh5dHZBZEF0TVBmRDNhck81UytFTThKaGhBcEw4bDZMTTk4NE53MkFv?=
 =?utf-8?B?TDNuRkI4a3FTYW05YjV6bGJFbzFsSndRMWpBVUp1bnVGb2lPTnFxREsvMXVS?=
 =?utf-8?B?aFJBZG14aTdjZjQ3eWNzWEZlak5NYWV1OWVZRTBYVkh6eFRmWFBSODZjaWVx?=
 =?utf-8?B?bnh6TUhMbXdyT01sOFFFQ09sU3BhMFFBdFhSdmZYaGpvMzVhallRbU5qRHhl?=
 =?utf-8?B?K295K1BXWVB1UmhTT3N4UTJOVVlLZmJMWnJ1Q1hla1NSV2xLKzFKekMxblgx?=
 =?utf-8?B?eGZrTXlZVGdLTDBFeWZhQ3k0V0pGZXdIVkRKTXoxeWlzTitTNlVCNWVjN3dm?=
 =?utf-8?B?ZmZRQkxSeERlc1VIR0ZHVUFQNUFEUlNUSGwwVk9teW41b3JBeVRVcXJnVUhB?=
 =?utf-8?B?UW5peTZubVdlaHZsbjh6c3hTRXFMMyszZXFLWnJyVzdmN1AvaGd4NUs1NzNi?=
 =?utf-8?B?b3lXaXZYYllMTE9ERldkTWxlcFdVUkpVTkQyRkliRUFrbWhlaEdxbCs4UG5v?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RFFzVkgxK0xNT1YvTTdvSFFqQm9yU0JhallUQ1JPN1EzRGZZSHc1eTFwQW5H?=
 =?utf-8?B?N1pjZG5sWTNzcUZiOCtRbGswZ3ZFcVFERFBNaG12S25JMG51emlxemdNZCto?=
 =?utf-8?B?TTkrNHBQNXZCbFJXVnpOMks5TDhpREhmRUFURzdxUDVjRm81N2lhY1VzdkN0?=
 =?utf-8?B?ZDdSa09OSWVnSjEycHJmSk9nVUZ6TmVOWi9jZlN4S3duZDFpVmc1L1B1UUNn?=
 =?utf-8?B?Ny9hUlRyWDZQM0o0bG1Da0RRc3lIVEFZSXNudUZFSWYyVC9WUHpXV0lXck5q?=
 =?utf-8?B?eGpXQUI2S3JvdE1LaUpJcmRMWWtxS0E5ZGFlNkFHRHdwWG5KN1lIYlVMWWlu?=
 =?utf-8?B?VTZ3eVZhbjNyekxtd1BnNE9FYTl5dlBFOWo2QjR4LzlONlMrN0trOEg4RGRY?=
 =?utf-8?B?SE5zWFdqcFpLcld1OUJFb2c0aDc2NXp1UzN0a1dCZ0t0Wmo5TmxpOTBlS0hs?=
 =?utf-8?B?aDc4dEE2aU1VMzlhWmhzNW5NeTN3ZjE2akgxK1RkdGxGYnFNeWpJTi9nZjh0?=
 =?utf-8?B?anhnYmwvSTdFZFcxSUVWeWxHdEVCdS9tUG9wU04zYUxoT0oxUnpMdmNyd2or?=
 =?utf-8?B?YkhlYlpSUnlXUWdxeHd3a0JGeTVjTFRqU0tRamtkeDZMU3NnMXlXTmxNVXlw?=
 =?utf-8?B?S1VpRitMSWU0TGM3QWNoaXVHb2lPdmFndGw4Uk1QRU9IMEtVaEdVN2JhNEU5?=
 =?utf-8?B?dUZvYmsrdVkva0ZmMjdOeExud0pxQjdwa004ZEhZWUhJV2lmNnpXWERLamFQ?=
 =?utf-8?B?TE54RS9GWmVYS0s3ZlNSd2VmOUZxcTFOYXVrYlZaZnZHUHpKMVRXRm1PV1Y3?=
 =?utf-8?B?SWdiYVAzM0lVMHYzM3BJWG9DZWpDVVRGRUIwTnRETHVEdXZWQ1J4OUZrd1I2?=
 =?utf-8?B?WmhDdmRVTnArMnZ2UkZYTFRJTGJtYzVXSkQvd2tOYjhXcDA0UEFGTWpBcUV5?=
 =?utf-8?B?NUV5MlRiSXozN3FYTUdIY3hGVEJqRHpVb3BYeXhCMENObmZGQzRqcjdGZUVP?=
 =?utf-8?B?djF3SXF0bXo2REZOR0VZMzRzL012a1piRFU4L2dsU2hPRWllcTVqTmVLUjdv?=
 =?utf-8?B?N0NKdjV4SktHZkltMkpYc1lSbmp3ZVVEZEJnK2tRTk13TE44a3NLMmxPL0ZQ?=
 =?utf-8?B?Tjc3N0Z5SkU5endEVVNTWVF5c2piM0JTR0F3bHo5cG8rOU9UKzFtdEFZYURL?=
 =?utf-8?B?TEhINE1wbXBWR01Wamp5YkVPaXpIZGxCemNkeXdsV2VJS1dSeUROdlFkOSs5?=
 =?utf-8?B?eEYyVGk1QUREWlA3QWQzamNHYVVkWWNwdVR4aDJPS3M3b3ZiWlpJbGFqYVph?=
 =?utf-8?B?RmpqZGtSQVNIWFB0eDVGVUdoNVBvWEVBS0k3aUF2ek1yQXcwaHk4SjNuS3ZB?=
 =?utf-8?B?a095ZUQwNEVRdHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319c8ca1-d564-4014-006e-08db886dfbc2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:36:56.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV276F7BMse4m6NRuoJXoC6YVE3r2uGbAVbZkNIXYQ3icQAJHWkhXEREoVExkNhpG26hmSdC6bIsFJLNj417wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_10,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190139
X-Proofpoint-GUID: jtuIHyxz49FqUDt0rrTsr5HkjTodrnN5
X-Proofpoint-ORIG-GUID: jtuIHyxz49FqUDt0rrTsr5HkjTodrnN5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 16:25, Ian Rogers wrote:
>> I was thinking about this a little further. So you suggest that the
>> metric expression contains PMU name per term, like
>> "cpu_atom@instructions@ / cpu_atom@cycles@" - how would/could this work
>> for PMUs with more complex naming, like the form hisi_siclXXX_cpa_YYY?
>> Would we use the "Unit" expression for the metric name, like
>> "@hisi_sicl,cpa@event_foo"?
> How does this work for events? The "@hisi_sicl,cpa@event_foo" looks
> strange, shouldn't it be "hisi_sicl,cpa@event_foo@" but then hisi_sicl
> looks like an event name.

Yeah, that was a typo from me - like you say, it would be 
hisi_sicl,cpa@event_foo@

So is that what you would be suggesting then, such that we specify the 
PMU in the metric terms? It does look a bit odd :)

> 
>>>> BTW, which git repo/branch do you guys use for dev? I thought that it
>>>> would be acme git, but Namhyung says "We moved to new repos from acme to
>>>> perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?
>>> Current development is here now:
>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next__;!!ACWV5N9M2RV99hQ!OQDHOClSjd6nVZhmgzrK3RwzXuQpP54QhqyIKpITa_MFD4PLdS7yPYSnvInFja9nrFx9Sd-UnlsJ6XUqAh4$
>> Can that be added to the MAINTAINERS file? I suppose it is ok under
>> "PERFORMANCE EVENTS SUBSYTEM", since the two would-be git repos listed
>> under that same entry would be pretty obvious in purpose.
> Arnaldo could you take a look at doing this?

Thanks,
John
