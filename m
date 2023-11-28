Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38AD7FB2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjK1H1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjK1H1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:27:03 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5CD6D;
        Mon, 27 Nov 2023 23:27:09 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AS20ROl031456;
        Tue, 28 Nov 2023 08:26:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=Ssqh7w0gyO7jZ8y3HEvt5
        feOCunBeqJzsQ7BVPvXVNk=; b=5+dddTwDgfGM3saJyJ2k6qe0mmiiWTsiflx7l
        kqL2iTnqTq+4O+DoQXIHkHtH99G7dh2FI4od5yIOQc2E2dolxWOa/4+6JttE3YMy
        Iw9oeL8PFkDMnEnp0E6hBQfvMe2qK7EcZTHg+HorMiLV+cn7/MCjC6yufeuncdds
        AzvFBq06XQV96oLm97nOA0HWhEemuZpWu/sflKcjwH9WT7NfSXo3HdhJX2CWr8ws
        StPHYOGms3pE/b+O9DOaHmU61338bLAKWyeeqmVnYMX2zTeG7m8XZ1MGCVAK0gXK
        3HA3VAINFSdLqUKrXPZMOgfYbJeWw4VNjazVYImuooe+QLZaA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk951u1j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 08:26:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9138910002A;
        Tue, 28 Nov 2023 08:26:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4458D214D20;
        Tue, 28 Nov 2023 08:26:53 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 Nov
 2023 08:26:53 +0100
Date:   Tue, 28 Nov 2023 08:26:45 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] media: i2c: st-mipid02: use active state to store
 pad formats
Message-ID: <20231128072645.GA1435577@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231125182057.1379357-1-alain.volmat@foss.st.com>
 <20231125182057.1379357-5-alain.volmat@foss.st.com>
 <ZWWLQkjvovzJMc73@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWWLQkjvovzJMc73@kekkonen.localdomain>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_06,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Nov 28, 2023 at 06:40:02AM +0000, Sakari Ailus wrote:
> On Sat, Nov 25, 2023 at 07:20:52PM +0100, Alain Volmat wrote:
> > Store formats information within pad allowing to simplify further more
> > the driver (mutex / format store within the driver structure no more
> > necessary).
> > 
> > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> 
> Applied with the following diff:
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index 7af209905d7b..2cc07b3ed0da 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -563,8 +563,8 @@ static const struct v4l2_mbus_framefmt default_fmt = {
>  	.height = 480,
>  };
>  
> -static int mipid02_init_cfg(struct v4l2_subdev *sd,
> -			    struct v4l2_subdev_state *state)
> +static int mipid02_init_state(struct v4l2_subdev *sd,
> +			      struct v4l2_subdev_state *state)
>  {
>  	*v4l2_subdev_state_get_format(state, MIPID02_SINK_0) = default_fmt;
>  	/* MIPID02_SINK_1 isn't supported yet */
> @@ -642,7 +642,6 @@ static const struct v4l2_subdev_video_ops mipid02_video_ops = {
>  };
>  
>  static const struct v4l2_subdev_pad_ops mipid02_pad_ops = {
> -	.init_cfg = mipid02_init_cfg,
>  	.enum_mbus_code = mipid02_enum_mbus_code,
>  	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = mipid02_set_fmt,
> @@ -653,6 +652,10 @@ static const struct v4l2_subdev_ops mipid02_subdev_ops = {
>  	.pad = &mipid02_pad_ops,
>  };
>  
> +static const struct v4l2_subdev_internal_ops mipid02_subdev_internal_ops = {
> +	.init_state = mipid02_init_state,
> +};
> +
>  static const struct media_entity_operations mipid02_subdev_entity_ops = {
>  	.link_validate = v4l2_subdev_link_validate,
>  };
> @@ -851,6 +854,7 @@ static int mipid02_probe(struct i2c_client *client)
>  
>  	bridge->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  	bridge->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> +	bridge->sd.internal_ops = &mipid02_subdev_internal_ops;
>  	bridge->sd.entity.ops = &mipid02_subdev_entity_ops;
>  	bridge->pad[0].flags = MEDIA_PAD_FL_SINK;
>  	bridge->pad[1].flags = MEDIA_PAD_FL_SINK;
> 

Thanks a lot Sakari for taking care of that !!

Regards,
Alain

> -- 
> Sakari Ailus
