Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04C97FADBA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjK0WyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjK0WyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:54:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90CD4B;
        Mon, 27 Nov 2023 14:54:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b4746ae3bso8659545e9.0;
        Mon, 27 Nov 2023 14:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701125658; x=1701730458; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIZZjVzYyIfXfJZDLrm8sokZX3uH1Dv9Mf0lFv/fkno=;
        b=VcVZtacneuv7akSQtibtXNqmROl+tlNMDBMcq5fRN/6NYaEK+nnXX4w3aB73fkLGME
         g/IZfcRz7CIboALlR7j/aP/JrqlfcfTOVzseh7tWHr5QM0lJ2uqreaCwmhF8YcBs6Pgi
         vWSP9o99dHye6KQPu2EWe+mpbCnNx3XExqEcPofM1Gs8TsrZLQCjaA+LLp89gD54Bw6K
         y8YHARW9oXbhNXNNM/4vHHvI+L8zCIBI4T3IZCBSuho2XqhyDLMwQEpJL0qi6w05vQRS
         UeBNeUdCwEz1Jphq5bkEGAUAg6uJJNm8TegpLTWV12YE7Vz917kDpKFQCHgqdo5aUyOp
         L9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701125658; x=1701730458;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIZZjVzYyIfXfJZDLrm8sokZX3uH1Dv9Mf0lFv/fkno=;
        b=URVulUO1sErCG7EAAsB4fCPsCPLZelRnd3MzWfoMTOSJAZ5SVcciK07wZdXV+CvowW
         WcVIFCXGkZC1RHIOoW92uVk2nVT5Qt33W2TBsJM2bgDfkVQJk4cLozhOeBMlz2wnb6+p
         hGOxusU36zT39FIVhepHqHIL2ii4z2RofBSSytxxcBD9Ffhq0ytJh3wtCsaCWLLyE/I+
         b54CG4t8ksaX3ad53ta6vKOTnELs+cBzRMMY+rFR7oNeBsHCk2J0HjVvit5B4y6UfuGj
         nzK4biNtAPwJ6D+rFOS7arNHsh2mg2Sb1MxPwN1TpqDWZdLla4hjHVVZM3kttJ6yvYzK
         OCMQ==
X-Gm-Message-State: AOJu0Yz3GWumdroVYbads8RYARvDhcegtfhX/mcxACJDvOxgcSnMwv8d
        7khaztMon6AB/zapeah2/Qo=
X-Google-Smtp-Source: AGHT+IEOptO9tc+DnBiK8/x4iOCPqjUwNymCAFCsQEo5iBKNgEhWeaNKzV748GEliI/QGLFHM8rUoQ==
X-Received: by 2002:a5d:6352:0:b0:332:d360:5df5 with SMTP id b18-20020a5d6352000000b00332d3605df5mr8416414wrw.54.1701125657881;
        Mon, 27 Nov 2023 14:54:17 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c138c00b004063c9f68f2sm15238589wmf.26.2023.11.27.14.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 14:54:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Nov 2023 23:54:17 +0100
Message-Id: <CX9YPUDTAT1N.23DMRB5O9FEAO@gmail.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>
Subject: Re: [PATCH] wifi: ath11k: fix layout of scan_flags in struct
 scan_req_params
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Jeff Johnson" <quic_jjohnson@quicinc.com>,
        "Kalle Valo" <kvalo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231127180559.1696041-1-nico.escande@gmail.com>
 <bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
In-Reply-To: <bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 27, 2023 at 7:38 PM CET, Jeff Johnson wrote:
> On 11/27/2023 10:05 AM, Nicolas Escande wrote:
> > The is a layout mismatch between the bitfield representing scan_flags i=
n
> > struct scan_req_params & the bits as defined in the WMI_SCAN_XXX macros=
.
> > Lets fix it by making the struct match the #defines.
> >=20
> > I tried to correct it by making the struct match the #define and it=20
> > worked for WMI_SCAN_FLAG_FORCE_ACTIVE_ON_DFS / scan_f_force_active_dfs_=
chn
> > so I'm assuming this is the right thing to do.
> >=20
> > Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> >=20
> > Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath11k/wmi.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wirele=
ss/ath/ath11k/wmi.h
> > index 100bb816b592..0b4e6c2f7860 100644
> > --- a/drivers/net/wireless/ath/ath11k/wmi.h
> > +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> > @@ -3348,17 +3348,17 @@ struct scan_req_params {
> >  			    scan_f_filter_prb_req:1,
> >  			    scan_f_bypass_dfs_chn:1,
> >  			    scan_f_continue_on_err:1,
> > +			    scan_f_promisc_mode:1,
> > +			    scan_f_force_active_dfs_chn:1,
> > +			    scan_f_add_tpc_ie_in_probe:1,
> > +			    scan_f_add_ds_ie_in_probe:1,
> > +			    scan_f_add_spoofed_mac_in_probe:1,
> >  			    scan_f_offchan_mgmt_tx:1,
> >  			    scan_f_offchan_data_tx:1,
> > -			    scan_f_promisc_mode:1,
> >  			    scan_f_capture_phy_err:1,
> >  			    scan_f_strict_passive_pch:1,
> >  			    scan_f_half_rate:1,
> >  			    scan_f_quarter_rate:1,
> > -			    scan_f_force_active_dfs_chn:1,
> > -			    scan_f_add_tpc_ie_in_probe:1,
> > -			    scan_f_add_ds_ie_in_probe:1,
> > -			    scan_f_add_spoofed_mac_in_probe:1,
> >  			    scan_f_add_rand_seq_in_probe:1,
> >  			    scan_f_en_ie_whitelist_in_probe:1,
> >  			    scan_f_forced:1,
>
> You are convoluting two different data structures.

So maybe I'm missing something and please correct me where I'm wrong.

> struct scan_req_params is used to represent a scan request within the
> host driver. This does not use the WMI_SCAN_XXX macros.
>

In mac.c when we start a scan with ath11k_mac_op_hw_scan() for example we f=
irst
initialize a struct scan_req_params with ath11k_wmi_start_scan_init().
ath11k_wmi_start_scan_init() by itself does use the WMI_SCAN_XXX macros

	arg->scan_flags |=3D WMI_SCAN_CHAN_STAT_EVENT;

Then later on in ath11k_mac_op_hw_scan() we either use the bitfield like wi=
th

	arg->scan_f_add_spoofed_mac_in_probe =3D 1;

or we directly modify scan_flags like with

	arg->scan_flags |=3D WMI_SCAN_FLAG_PASSIVE;

So is it not expected to use those flags there ?

> struct wmi_start_scan_cmd is used to represent the scan request command
> sent to firmware. This struct uses the WMI_SCAN_XXX macros to fill some
> members of this struct in ath11k_wmi_copy_scan_event_cntrl_flags().

Indeed ath11k_wmi_copy_scan_event_cntrl_flags() copies from struct
scan_req_params to struct wmi_start_scan_cmd but this time we do not use=20
scan_flags directly, only ever use the bitfield that is in the same union
as scan_flags

So having the bitfield out of sync does cause the struct wmi_start_scan_cmd=
 that
gets sent to the driver to not reflect the desired state set in scan_req_pa=
rams.

> So your change has no effect on the driver operation and incorrectly
> tries to foist the firmware definition upon the host internal
> representation.

So either we should not use WMI_SCAN_XXX with scan_req_params.scan_flags ev=
er
and only use the bitfield to set scan parameters or if we use WMI_SCAN_XXX =
with
scan_req_params.scan_flags they need to match the corresponding bitfield.

>
> So NAK to this patch.
>
> /jeff
