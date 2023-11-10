Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528CF7E7829
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbjKJDk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjKJDk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:40:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E144BD;
        Thu,  9 Nov 2023 19:40:25 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA2RCQp011798;
        Fri, 10 Nov 2023 03:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H3TWk7+4y1gJTkIKtnz7CfGBX9WDO7ArE0fYsNIipiE=;
 b=k56nCrzqGU55hzTgCmwnbTPpFNAiXIdYEi7fLqqWq6AWGAmtlaRfap9ux3J3WFsyrC08
 FGMdawhdfwYNAtJ5f7jY25K0HHxzuEeoncf6cDLe0sa2t89Y9779Osrb/RnRL1LbqkKt
 HXLn6mwgRun42otXTrJHPlJHNH2x8/JclZ6GIaN1ihy4v2wzTRKEylZnQ0dy4FrhcFtd
 d9pM/cNxO7svEbz1MG9wMBvijJeKC3/NloFN4afb4CkzWk4ZPO3v6E+acMlJJDfdWgSI
 ve2mfx8/ZFmyqLaQDWUjCA9qlYNOwPhXyAYfOSLeCOXHtNET1YIpz7fJr2NJdoJ+1Wun IA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93qy92x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:40:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA3e9bO007047
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:40:09 GMT
Received: from [10.253.38.123] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 19:40:06 -0800
Message-ID: <fa1fa85a-0ef4-4e77-876e-c4c3e54fbb1f@quicinc.com>
Date:   Fri, 10 Nov 2023 11:40:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event
 of a disable channel
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, <mani@kernel.org>,
        <quic_jhugo@quicinc.com>
CC:     <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <12ceff53-bbd0-4e12-9597-f6a4bfd0f87f@kadam.mountain>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <12ceff53-bbd0-4e12-9597-f6a4bfd0f87f@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t1_0Fnd_Ogvb2yQpD1OjtjC5RS77qzv0
X-Proofpoint-GUID: t1_0Fnd_Ogvb2yQpD1OjtjC5RS77qzv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=907 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/2023 2:48 PM, Dan Carpenter wrote:
> Hi Qiang,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Yu/bus-mhi-host-Add-spinlock-to-protect-WP-access-when-queueing-TREs/20231107-151918
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
> patch link:    https://lore.kernel.org/r/1699341365-47737-4-git-send-email-quic_qianyu%40quicinc.com
> patch subject: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event of a disable channel
> config: x86_64-randconfig-161-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080155.MiyREgoQ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080155.MiyREgoQ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202311080155.MiyREgoQ-lkp@intel.com/
>
> smatch warnings:
> drivers/bus/mhi/host/main.c:1257 mhi_gen_tre() warn: inconsistent returns '&mhi_chan->lock'.
>
> vim +1257 drivers/bus/mhi/host/main.c
>
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1204  int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1205  			struct mhi_buf_info *info, enum mhi_flags flags)
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1206  {
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1207  	struct mhi_ring *buf_ring, *tre_ring;
> 84f5f31f110e5e drivers/bus/mhi/host/main.c Manivannan Sadhasivam 2022-03-01  1208  	struct mhi_ring_element *mhi_tre;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1209  	struct mhi_buf_info *buf_info;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1210  	int eot, eob, chain, bei;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1211  	int ret;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1212
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1213  	/* Protect accesses for reading and incrementing WP */
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1214  	write_lock_bh(&mhi_chan->lock);
> 6025cde6ecb13c drivers/bus/mhi/host/main.c Qiang Yu              2023-11-07  1215  	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
> 6025cde6ecb13c drivers/bus/mhi/host/main.c Qiang Yu              2023-11-07  1216  		return -EINVAL;
>
> This looks like two people submitted patches on the same day?
> We should unlock before returning?
Yes, we should unlock before return, will change in next version patch. 
Thank you.
>
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1217
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1218  	buf_ring = &mhi_chan->buf_ring;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1219  	tre_ring = &mhi_chan->tre_ring;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1220
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1221  	buf_info = buf_ring->wp;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1222  	WARN_ON(buf_info->used);
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1223  	buf_info->pre_mapped = info->pre_mapped;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1224  	if (info->pre_mapped)
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1225  		buf_info->p_addr = info->p_addr;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1226  	else
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1227  		buf_info->v_addr = info->v_addr;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1228  	buf_info->cb_buf = info->cb_buf;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1229  	buf_info->wp = tre_ring->wp;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1230  	buf_info->dir = mhi_chan->dir;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1231  	buf_info->len = info->len;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1232
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1233  	if (!info->pre_mapped) {
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1234  		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1235  		if (ret) {
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1236  			write_unlock_bh(&mhi_chan->lock);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1237  			return ret;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1238  		}
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1239  	}
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1240
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1241  	eob = !!(flags & MHI_EOB);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1242  	eot = !!(flags & MHI_EOT);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1243  	chain = !!(flags & MHI_CHAIN);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1244  	bei = !!(mhi_chan->intmod);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1245
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1246  	mhi_tre = tre_ring->wp;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1247  	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1248  	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1249  	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1250
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1251  	/* increment WP */
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1252  	mhi_add_ring_element(mhi_cntrl, tre_ring);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1253  	mhi_add_ring_element(mhi_cntrl, buf_ring);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1254
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1255  	write_unlock_bh(&mhi_chan->lock);
> da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1256
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20 @1257  	return 0;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1258  }
>
