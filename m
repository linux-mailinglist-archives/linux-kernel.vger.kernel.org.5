Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFB7B63EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjJCIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjJCIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:19:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E79B;
        Tue,  3 Oct 2023 01:19:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3936IMQB006279;
        Tue, 3 Oct 2023 08:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=TcTNHIkQ4u7p4BAUZJiauYpzglJBMjfppSZlDSU/BEs=;
 b=oHJiWFNg6t5Ubk5u9+3JUmnKliT7XK3vX+clNZUkabl5fLO3rkCM+/UooqvYaDnUZBgm
 rQLGBXcxjnRfqM78RRDMzk1sKAfnby6sA1zr4P4Gml8MLEefm0PeGpfg4N4/kO38WhMD
 LWTSBst9O2vgpkWxw+doh4veN9KKDdCV4zCV1fGrKkxIS9wHBubD+/lKHq4X1HJKfD+P
 3XGI//1y252OxCoSfyCD0JYCpEdc4p0tlXza8QWupBMuqWE7pWcK2cN76lt9b8u37wdS
 CliLgCJMjL9G8Nm48XMRM4i8+/44P09rKLtEpzLknUHrxvjr7E+bdz78GDYyNpHmr99/ GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3teb0sdfmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 08:19:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3938JdPG028623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 08:19:39 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 01:19:33 -0700
Date:   Tue, 3 Oct 2023 13:49:31 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Nikhil V <quic_nprakash@quicinc.com>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: Re: [RFC PATCH 4/4] PM: hibernate: Support to select compression
 algorithm
Message-ID: <a1b86dcb-8783-4038-83a9-278e5ddc109b@quicinc.com>
References: <cover.1695711299.git.quic_nprakash@quicinc.com>
 <b49a7bdd957bf86913700220b6c1f8f12c753b52.1695711299.git.quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b49a7bdd957bf86913700220b6c1f8f12c753b52.1695711299.git.quic_nprakash@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u0CueN4UH5JRGEfWEM-_T2cJQeyN29GJ
X-Proofpoint-ORIG-GUID: u0CueN4UH5JRGEfWEM-_T2cJQeyN29GJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:27:14PM +0530, Nikhil V wrote:
> +static const char * const comp_alg_enabled[] = {
> +#if IS_ENABLED(CONFIG_CRYPTO_LZO)
> +	COMPRESSION_ALGO_LZO,
> +#endif
> +#if IS_ENABLED(CONFIG_CRYPTO_LZ4)
> +	COMPRESSION_ALGO_LZ4,
> +#endif
> +};
> +
> +static int __init compression_setup(char *str)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(comp_alg_enabled); i++) {
> +		if (!strcmp(str, comp_alg_enabled[i])) {
> +			strscpy(hib_comp_algo, str, sizeof(hib_comp_algo));
> +			goto setup_done;
> +		}
> +	}
> +	strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
> +
> +setup_done:
> +	return 1;
> +}
> +
>  __setup("noresume", noresume_setup);
>  __setup("resume_offset=", resume_offset_setup);
>  __setup("resume=", resume_setup);
> @@ -1423,3 +1449,4 @@ __setup("hibernate=", hibernate_setup);
>  __setup("resumewait", resumewait_setup);
>  __setup("resumedelay=", resumedelay_setup);
>  __setup("nohibernate", nohibernate_setup);
> +__setup("hib_compression=", compression_setup);
> -- 

If I pass hib_compression=lz4 without enabling CONFIG_CRYPTO_LZ4, It
silently makes the compression to lzo which is expected from this code.
It would be good if an error/info message is printed in
compression_setup() which this happens.

Thanks,
Pavan
