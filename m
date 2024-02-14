Return-Path: <linux-kernel+bounces-65853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8A8552D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE4B1C24053
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3513A862;
	Wed, 14 Feb 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UJLUOgau"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C8134740;
	Wed, 14 Feb 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937175; cv=none; b=f1NfHkNMcrmWgwk7LZwMHKmKdQggwRDqwcKtxhCSq/XYhuFNz7ahuVuKaLqBhPnKDQehSwL9P3JXHZQxSH47MfblJZOv6ycYlch2XLiYtMQZjoBNXGzZrc3qKM32GQloFftTYPcRyoIduee+4AJxO19AzprIHAjRnwzbT4S3gmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937175; c=relaxed/simple;
	bh=GB0BKS8fWdTvs6GuUClpKuNugxRB1vPoFICmMIbUOW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNkuSxv6L9EPkY17YspTncYMNidrAFMeKmIka1Uj2mvF9GcAd8+fcfwl24xeQj9RX6rFfh/CKLmc80UzmnyuDBuFcrwBUD2kOj69uJTJlvka9w1znzIh6LTdQySN3Yh7+5+m8/M1uGrSG4GnLiatUXkW7EfePGoziGsN2nuIW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UJLUOgau; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EH7DQ6030605;
	Wed, 14 Feb 2024 18:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=V9z839rJNjuYe92slWNUR
	dhJDgVQJkr1tMFTUmBdnrY=; b=UJLUOgau/b/BlpJTwE1Cf1M3qnt/NZar8c74b
	lQv/4Q+rwhcyagI7zq1QC+HhY0jO9xg3qAVMMXj7ugqfmUcLqDDHgX9KyhPzVNT9
	ouKuepdGxOZt7LHw3SR5pkxvcyakRgP3A/mepQFoKia4uR8F1Gjm9t/6PFQHS84N
	XHg/hZUT4saFL58cjnQ2gCBECMji/rOFjJrl0ujJGlWO+QyqyOX6vHqHKny7S/Gj
	ZZig7eGKdx0DkqwzXJ07s7FhBPaalLcKBkCn/zI/Z+S/fb0lUMM+8voHAO4AlZTn
	3FPYO4d+H7THnRr4xJt6lw+Y9gdSkDvtp18rGoStJwBVg8YVg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8448uwmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:59:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EIxQmn006620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:59:26 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 10:59:25 -0800
Date: Wed, 14 Feb 2024 10:59:25 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
CC: Maulik Shah <quic_mkshah@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_lsrao@quicinc.com>,
        <stable@vger.kernel.org>
Subject: Re: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM
 in-flight request
Message-ID: <20240214105605460-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
	quic_lsrao@quicinc.com, stable@vger.kernel.org
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
 <sizizst7xkexl3dd26sssgxtjhk7mcrawswbs76vdutsxsm6qh@mvilvzwydjpm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <sizizst7xkexl3dd26sssgxtjhk7mcrawswbs76vdutsxsm6qh@mvilvzwydjpm>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XbKRlPrySHtgF63yMlCTrIBmWV3DFPwr
X-Proofpoint-GUID: XbKRlPrySHtgF63yMlCTrIBmWV3DFPwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402140148

On Wed, Feb 14, 2024 at 12:08:43AM -0600, Bjorn Andersson wrote:
> On Mon, Feb 12, 2024 at 10:18:08AM +0530, Maulik Shah wrote:
> > Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
> > addresses associated with it. These control voltage, enable state, mode,
> > and in legacy targets, voltage headroom. The current in-flight request
> > checking logic looks for exact address matches. Requests for different
> > addresses of the same RPMh resource as thus not detected as in-flight.
> > 
> > Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
> > request check for VRM requests by ignoring the address offset.
> > 
> > This ensures that only one request is allowed to be in-flight for a given
> > VRM resource. This is needed to avoid scenarios where request commands are
> > carried out by RPMh hardware out-of-order leading to LDO regulator
> > over-current protection triggering.
> > 
> > Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
> > cc: stable@vger.kernel.org
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> 
> This says, "Elliot first certified the origin of the patch, then Maulik
> took and certified the origin of the patch". But according to the From:
> the author of the patch is you, Maulik.
> 
> How was Elliot able to certify the patch's origin before you, when
> you're the author?
> 
> If the two of you collaborated, also add Co-developed-by: Elliot above
> his s-o-b.
> 

Even my Co-developed-by is being generous :-) All I had done was copy
the commit and resolve couple merge conflicts.

Maulik, you can swap my S-o-B for a:

Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd

> > ---
> > Changes in v3:
> > - Fix s-o-b chain
> > - Add cmd-db API to compare addresses
> > - Reuse already defined resource types in cmd-db
> > - Add Fixes tag and Cc to stable
> > - Retain Reviewed-by tag of v2
> > - Link to v2: https://lore.kernel.org/r/20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com
> > Changes in v2:
> > - Use GENMASK() and FIELD_GET()
> > - Link to v1: https://lore.kernel.org/r/20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com
> > ---
> >  drivers/soc/qcom/cmd-db.c   | 41 +++++++++++++++++++++++++++++++++++------
> >  drivers/soc/qcom/rpmh-rsc.c |  3 ++-
> >  include/soc/qcom/cmd-db.h   | 10 +++++++++-
> >  3 files changed, 46 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index a5fd68411bed..e87682b9755e 100644
> > --- a/drivers/soc/qcom/cmd-db.c
> > +++ b/drivers/soc/qcom/cmd-db.c
> > @@ -1,6 +1,10 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -/* Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved. */
> > +/*
> > + * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -15,8 +19,8 @@
> >  
> >  #define NUM_PRIORITY		2
> >  #define MAX_SLV_ID		8
> > -#define SLAVE_ID_MASK		0x7
> > -#define SLAVE_ID_SHIFT		16
> > +#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
> > +#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
> >  
> >  /**
> >   * struct entry_header: header for each entry in cmddb
> > @@ -221,9 +225,34 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
> >  EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
> >  
> >  /**
> > - * cmd_db_read_slave_id - Get the slave ID for a given resource address
> > + * cmd_db_match_resource_addr - Compare if both Resource addresses are same
> 
> () after the function name, please.
> 
> > + *
> > + * @addr1: Resource address to compare
> > + * @addr2: Resource address to compare
> > + *
> > + * Return: true on matching addresses, false otherwise
> 
> "Return: true if the two addresses refer to the same resource"
> 
> > + */
> > +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
> > +{
> > +	/*
> > +	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
> > +	 * aligned addresses associated with it. Ignore the offset to check
> > +	 * for VRM requests.
> > +	 */
> > +	if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
> > +	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
> 
> One line please, it's just 83 characters.
> 
> > +		return true;
> > +	else if (addr1 == addr2)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> > +EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
> > +
> > +/**
> > + * cmd_db_read_slave_id - Get the slave ID for a given resource name
> >   *
> > - * @id: Resource id to query the DB for version
> > + * @id: Resource id to query the DB for slave id
> 
> Although trivial, it's unrelated to the newly introduced logic. Please
> submit a separate patch. Please also then add the () after the function
> name.
> 
> Regards,
> Bjorn
> 
> >   *
> >   * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
> >   */
> > @@ -238,7 +267,7 @@ enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
> >  		return CMD_DB_HW_INVALID;
> >  
> >  	addr = le32_to_cpu(ent->addr);
> > -	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
> > +	return SLAVE_ID(addr);
> >  }
> >  EXPORT_SYMBOL_GPL(cmd_db_read_slave_id);
> >  
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index a021dc71807b..daf64be966fe 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
> >   */
> >  
> >  #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
> > @@ -557,7 +558,7 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
> >  		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
> >  			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
> >  			for (k = 0; k < msg->num_cmds; k++) {
> > -				if (addr == msg->cmds[k].addr)
> > +				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
> >  					return -EBUSY;
> >  			}
> >  		}
> > diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
> > index c8bb56e6852a..47a6cab75e63 100644
> > --- a/include/soc/qcom/cmd-db.h
> > +++ b/include/soc/qcom/cmd-db.h
> > @@ -1,5 +1,8 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
> > +/*
> > + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> >  
> >  #ifndef __QCOM_COMMAND_DB_H__
> >  #define __QCOM_COMMAND_DB_H__
> > @@ -21,6 +24,8 @@ u32 cmd_db_read_addr(const char *resource_id);
> >  
> >  const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
> >  
> > +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
> > +
> >  enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
> >  
> >  int cmd_db_ready(void);
> > @@ -31,6 +36,9 @@ static inline u32 cmd_db_read_addr(const char *resource_id)
> >  static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
> >  { return ERR_PTR(-ENODEV); }
> >  
> > +static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
> > +{ return false; }
> > +
> >  static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
> >  { return -ENODEV; }
> >  
> > 
> > ---
> > base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
> > change-id: 20240210-rpmh-rsc-fixes-372a79ab364b
> > 
> > Best regards,
> > -- 
> > Maulik Shah <quic_mkshah@quicinc.com>
> > 

