Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C437C7EA0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjKMQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:08:32 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5E1A2;
        Mon, 13 Nov 2023 08:08:28 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so66430721fa.1;
        Mon, 13 Nov 2023 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699891706; x=1700496506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UW5qx6i7b4DrzXNONGQsnNb1tTaIrCw/M1F9WJRKViE=;
        b=dmzULFqYCb+psiSZppegZ06oDu7SDmiB/G0MNlPa02ztO1A8A8h7BOc4Z14XL7lJ43
         CGJqkCHBmcE+4j5wiQo6QqNv0JVEOATU+6MXn2rAFcnkULLXH6xRRA4vf5f5uqV1x/yU
         g/0QE54XIGS7j4d0SJnZmoN8UHQ5bpWM7EwsVVEqbmL/DW76FarPLsNhpy4f086RIs0w
         +oyoB0PEu4sM1kMQo+74ndiBRj9d5KGJftnJ+Ox3uys01Vb+6+gMNxHOOnPYHbBXk94t
         RCWGxHPQCNT9QlHcJiObxVkNcu9qotXfgesrStnEUpJcFzmMvSNeGe4S/VIRy4bGtasF
         ydEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699891706; x=1700496506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UW5qx6i7b4DrzXNONGQsnNb1tTaIrCw/M1F9WJRKViE=;
        b=HCTCxAhS9UGQ9ATpEFOFQqnGQyxnhz+BADOBfejfgTUAJ0QvL3fkJ8UnQlZsGPOOnp
         SymEnfoGjfscyQ4c5FnA0fUgX3HMp0r+nKRPAnmRguYZq0U/lry3PrAyhF06i4X2xjzY
         kp4X5robGJ1zkpy8j8dx4mjQDZToWaWvELhbjIroD3LbXcDPuFecvHEAQsNJm6ncww9n
         1Fxh6EUvwUDJ4wEseSZ6Ajn8A//v697MNOLC1qIhuVlDVbs97wGmwiOAznY5CdLOxCcY
         2qiE9C/OOo5qBq4BNAX0C1B74xgzI6DJlsCtu7kt+i+mwJ88Qpj2MF4cVScQryBg8wKW
         sUNw==
X-Gm-Message-State: AOJu0YxfgG43Mzq4VQ2S2EcK99nlIjHeHZxF9UobfsFHGDtC6ZXXno4K
        RQSguU+Q/BexH5mSsSba7NU=
X-Google-Smtp-Source: AGHT+IFVnlEmhbk7PU6ep2kZ6m8Y68kvW/3exeN1lgMU8Cg5hlOKcGE46krnpFAtgh78cUaKTp/K+Q==
X-Received: by 2002:a2e:97c3:0:b0:2bc:f5a0:cc25 with SMTP id m3-20020a2e97c3000000b002bcf5a0cc25mr5234411ljj.2.1699891706026;
        Mon, 13 Nov 2023 08:08:26 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b004081a011c0esm14110746wma.12.2023.11.13.08.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 08:08:25 -0800 (PST)
Message-ID: <4ff1f3f1-15b2-479b-898e-1a4fa50e6f19@gmail.com>
Date:   Mon, 13 Nov 2023 17:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: add a debugfs interface for the DMUB
 trace mask
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Aric Cyr <aric.cyr@amd.com>, linux-doc@vger.kernel.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        dri-devel@lists.freedesktop.org, Reza Amini <reza.amini@amd.com>,
        Anthony Koo <anthony.koo@amd.com>,
        Mustapha Ghaddar <mghaddar@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@gmail.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Tony Tascioglu <tony.tascioglu@amd.com>,
        Fangzhi Zuo <jerry.zuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Li <sunpeng.li@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20231113145608.20386-1-hamza.mahfooz@amd.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231113145608.20386-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.11.23 um 15:56 schrieb Hamza Mahfooz:
> For features that are implemented primarily in DMUB (e.g. PSR), it is
> useful to be able to trace them at a DMUB level from the kernel,
> especially when debugging issues. So, introduce a debugfs interface that
> is able to read and set the DMUB trace mask dynamically at runtime and
> document how to use it.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> v2: only return -ETIMEDOUT for DMUB_STATUS_TIMEOUT
> ---
>   Documentation/gpu/amdgpu/display/dc-debug.rst | 41 ++++++++
>   .../gpu/amdgpu/display/trace-groups-table.csv | 29 ++++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 97 +++++++++++++++++++
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 40 +++++++-
>   4 files changed, 205 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/gpu/amdgpu/display/trace-groups-table.csv
>
> diff --git a/Documentation/gpu/amdgpu/display/dc-debug.rst b/Documentation/gpu/amdgpu/display/dc-debug.rst
> index 40c55a618918..817631b1dbf3 100644
> --- a/Documentation/gpu/amdgpu/display/dc-debug.rst
> +++ b/Documentation/gpu/amdgpu/display/dc-debug.rst
> @@ -75,3 +75,44 @@ change in real-time by using something like::
>   
>   When reporting a bug related to DC, consider attaching this log before and
>   after you reproduce the bug.
> +
> +DMUB Firmware Debug
> +===================
> +
> +Sometimes, dmesg logs aren't enough. This is especially true if a feature is
> +implemented primarily in DMUB firmware. In such cases, all we see in dmesg when
> +an issue arises is some generic timeout error. So, to get more relevant
> +information, we can trace DMUB commands by enabling the relevant bits in
> +`amdgpu_dm_dmub_trace_mask`.
> +
> +Currently, we support the tracing of the following groups:
> +
> +Trace Groups
> +------------
> +
> +.. csv-table::
> +   :header-rows: 1
> +   :widths: 1, 1
> +   :file: ./trace-groups-table.csv
> +
> +**Note: Not all ASICs support all of the listed trace groups**
> +
> +So, to enable just PSR tracing you can use the following command::
> +
> +  # echo 0x8020 > /sys/kernel/debug/dri/0/amdgpu_dm_dmub_trace_mask
> +
> +Then, you need to enable logging trace events to the buffer, which you can do
> +using the following::
> +
> +  # echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
> +
> +Lastly, after you are able to reproduce the issue you are trying to debug,
> +you can disable tracing and read the trace log by using the following::
> +
> +  # echo 0 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
> +  # cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_tracebuffer
> +
> +So, when reporting bugs related to features such as PSR and ABM, consider
> +enabling the relevant bits in the mask before reproducing the issue and
> +attach the log that you obtain from the trace buffer in any bug reports that you
> +create.
> diff --git a/Documentation/gpu/amdgpu/display/trace-groups-table.csv b/Documentation/gpu/amdgpu/display/trace-groups-table.csv
> new file mode 100644
> index 000000000000..3f6a50d1d883
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/display/trace-groups-table.csv
> @@ -0,0 +1,29 @@
> +Name, Mask Value
> +INFO, 0x1
> +IRQ SVC, 0x2
> +VBIOS, 0x4
> +REGISTER, 0x8
> +PHY DBG, 0x10
> +PSR, 0x20
> +AUX, 0x40
> +SMU, 0x80
> +MALL, 0x100
> +ABM, 0x200
> +ALPM, 0x400
> +TIMER, 0x800
> +HW LOCK MGR, 0x1000
> +INBOX1, 0x2000
> +PHY SEQ, 0x4000
> +PSR STATE, 0x8000
> +ZSTATE, 0x10000
> +TRANSMITTER CTL, 0x20000
> +PANEL CNTL, 0x40000
> +FAMS, 0x80000
> +DPIA, 0x100000
> +SUBVP, 0x200000
> +INBOX0, 0x400000
> +SDP, 0x4000000
> +REPLAY, 0x8000000
> +REPLAY RESIDENCY, 0x20000000
> +CURSOR INFO, 0x80000000
> +IPS, 0x100000000
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 45c972f2630d..67dea56cf583 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -2971,6 +2971,100 @@ static int allow_edp_hotplug_detection_set(void *data, u64 val)
>   	return 0;
>   }
>   
> +static int dmub_trace_mask_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
> +	enum dmub_gpint_command cmd;
> +	enum dmub_status status;
> +	u64 mask = 0xffff;
> +	u8 shift = 0;
> +	u32 res;
> +	int i;
> +
> +	if (!srv->fw_version)
> +		return -EINVAL;
> +
> +	for (i = 0;  i < 4; i++) {
> +		res = (val & mask) >> shift;
> +
> +		switch (i) {
> +		case 0:
> +			cmd = DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD0;
> +			break;
> +		case 1:
> +			cmd = DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1;
> +			break;
> +		case 2:
> +			cmd = DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD2;
> +			break;
> +		case 3:
> +			cmd = DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD3;
> +			break;
> +		}
> +
> +		status = dmub_srv_send_gpint_command(srv, cmd, res, 30);
> +
> +		if (status == DMUB_STATUS_TIMEOUT)
> +			return -ETIMEDOUT;
> +		else if (status != DMUB_STATUS_OK)
> +			return -EIO;
> +
> +		usleep_range(100, 1000);
> +
> +		mask <<= 16;
> +		shift += 16;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dmub_trace_mask_show(void *data, u64 *val)
> +{
> +	enum dmub_gpint_command cmd = DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD0;
> +	struct amdgpu_device *adev = data;
> +	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
> +	enum dmub_status status;
> +	u8 shift = 0;
> +	u64 raw = 0;
> +	u64 res = 0;
> +	int i = 0;
> +
> +	if (!srv->fw_version)
> +		return -EINVAL;
> +
> +	while (i < 4) {
> +		status = dmub_srv_send_gpint_command(srv, cmd, 0, 30);
> +
> +		if (status == DMUB_STATUS_OK) {
> +			status = dmub_srv_get_gpint_response(srv, (u32 *) &raw);
> +
> +			if (status == DMUB_STATUS_TIMEOUT)
> +				return -ETIMEDOUT;
> +			else if (status != DMUB_STATUS_OK)
> +				return -EIO;
> +		} else if (status == DMUB_STATUS_TIMEOUT) {
> +			return -ETIMEDOUT;
> +		} else {
> +			return -EIO;
> +		}
> +
> +		usleep_range(100, 1000);
> +
> +		cmd++;
> +		res |= (raw << shift);
> +		shift += 16;
> +		i++;
> +	}
> +
> +	*val = res;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(dmub_trace_mask_fops, dmub_trace_mask_show,
> +			 dmub_trace_mask_set, "0x%llx\n");
> +
>   /*
>    * Set dmcub trace event IRQ enable or disable.
>    * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
> @@ -3884,6 +3978,9 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
>   	debugfs_create_file_unsafe("amdgpu_dm_force_timing_sync", 0644, root,
>   				   adev, &force_timing_sync_ops);
>   
> +	debugfs_create_file_unsafe("amdgpu_dm_dmub_trace_mask", 0644, root,
> +				   adev, &dmub_trace_mask_fops);
> +
>   	debugfs_create_file_unsafe("amdgpu_dm_dmcub_trace_event_en", 0644, root,
>   				   adev, &dmcub_trace_event_state_fops);
>   
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index ed4379c04715..aa6e6923afed 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -818,18 +818,54 @@ enum dmub_gpint_command {
>   	 * RETURN: Lower 32-bit mask.
>   	 */
>   	DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK = 101,
> +
>   	/**
> -	 * DESC: Updates the trace buffer lower 32-bit mask.
> +	 * DESC: Updates the trace buffer mask bit0~bit15.
>   	 * ARGS: The new mask
>   	 * RETURN: Lower 32-bit mask.
>   	 */
>   	DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD0 = 102,
> +
>   	/**
> -	 * DESC: Updates the trace buffer mask bi0~bit15.
> +	 * DESC: Updates the trace buffer mask bit16~bit31.
>   	 * ARGS: The new mask
>   	 * RETURN: Lower 32-bit mask.
>   	 */
>   	DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1 = 103,
> +
> +	/**
> +	 * DESC: Updates the trace buffer mask bit32~bit47.
> +	 * ARGS: The new mask
> +	 * RETURN: Lower 32-bit mask.
> +	 */
> +	DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD2 = 114,
> +
> +	/**
> +	 * DESC: Updates the trace buffer mask bit48~bit63.
> +	 * ARGS: The new mask
> +	 * RETURN: Lower 32-bit mask.
> +	 */
> +	DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD3 = 115,
> +
> +	/**
> +	 * DESC: Read the trace buffer mask bi0~bit15.
> +	 */
> +	DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD0 = 116,
> +
> +	/**
> +	 * DESC: Read the trace buffer mask bit16~bit31.
> +	 */
> +	DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD1 = 117,
> +
> +	/**
> +	 * DESC: Read the trace buffer mask bi32~bit47.
> +	 */
> +	DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD2 = 118,
> +
> +	/**
> +	 * DESC: Updates the trace buffer mask bit32~bit63.
> +	 */
> +	DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD3 = 119,
>   };
>   
>   /**

