Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBC7A4CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjIRPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjIRPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:41:50 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70666E4D;
        Mon, 18 Sep 2023 08:40:21 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c43166b7e5so29452705ad.3;
        Mon, 18 Sep 2023 08:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051385; x=1695656185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cD+cmIkq/0xe1bl+vQZsxyzlQSlIBNKWB/nPmFWtiM=;
        b=VgnYRtgtEY4P8rHQVoQoWxW4+wVIftOauhOF572nXZgKA3Ny5fq6EXDNI5t73lkkty
         1hyYwTrAimQ0EC0G4lMddweexCi3TlmQPiyv1jbx3ZkAY9VmrmAzUTDVauyd3ASnNjod
         W6v1JRGGSWfY+VBxCQaQODmfY8wx3RFPzu5+baKyBVtAnU0C8d5UCrjPiRyOPQJX5/HA
         xvfjJy63ol88Emxs6p5kCiHrf79oDNcFPGHv16EeFKjt4ZmIA8UuxIyhkL6zK8+zXBFt
         zQ3asvsAv1BNrAItTRRuhgmKYOBXjNP0rS4fHKnoVVK3cDvyDXdeVe7CDO8D/DpOc1GO
         aokA==
X-Gm-Message-State: AOJu0YxAWh7tQ2NmU0YobMVE6hJas7waFzoS8kk1zt+6iI802G4CwpJ0
        oWTXFXRYR2EmuT52vP/EQ24=
X-Google-Smtp-Source: AGHT+IGR184+HRuFV3B3NfFTF4LThXA2jwJxkhQ6O8Hu6lLmMW70MpsX8E267KMD6Pk87zk9rLPvEQ==
X-Received: by 2002:a17:903:32cd:b0:1c4:1343:8329 with SMTP id i13-20020a17090332cd00b001c413438329mr11852832plr.27.1695051385239;
        Mon, 18 Sep 2023 08:36:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:33e7:1437:5d00:8e3b? ([2620:15c:211:201:33e7:1437:5d00:8e3b])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001b9d95945afsm8464160plf.155.2023.09.18.08.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:36:23 -0700 (PDT)
Message-ID: <de7e76f8-5ed6-4de0-8084-24e220deb4b3@acm.org>
Date:   Mon, 18 Sep 2023 08:36:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] scsi: ufs: ufs-sysfs: Introduce UFS power info sysfs
 nodes
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-7-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1694411968-14413-7-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 22:59, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bounch of power saving
> features and various combinations for backward compatiblity.

bounch -> bunch
compatiblity -> compatibility

Additionally, please combine this patch with patch 5/6 into a single patch.

> -What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_sum
> -What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_sum
> -Date:		January 2021

Has the above information perhaps been removed by accident?

> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/gear
> +What:		/sys/bus/platform/devices/*.ufs/power_info/gear
> +Date:		September 2023
>   Contact:	Can Guo <quic_cang@quicinc.com>
> -Description:	This file shows the total latency (in micro seconds) of write
> -		requests after monitor gets started.
> +Description:	This file shows the gear of UFS link.
> +
> +		The file is read only.

Please explain what "gear" means and also what the unit is of the 
numbers reported via this sysfs attribute.

> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/mode
> +What:		/sys/bus/platform/devices/*.ufs/power_info/mode
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the power mode of UFS link.
> +
> +		The file is read only.

Please document the meaning of the numbers reported via this sysfs 
attribute.

> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/rate
> +What:		/sys/bus/platform/devices/*.ufs/power_info/rate
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the high speed rate of UFS link.
> +
> +		The file is read only.

Please document the unit of the numbers reported via this sysfs attribute.

> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
> +What:		/sys/bus/platform/devices/*.ufs/power_info/dev_pm
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the UFS device power mode, i.e., the power mode
> +		set to UFS device via the Start Stop Unit command.

Please document the meaning of the numbers reported through this sysfs 
attribute.

> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/link_state
> +What:		/sys/bus/platform/devices/*.ufs/power_info/link_state
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the the state of the UFS link.

Please document the meaning of the numbers reported through this sysfs 
attribute.

Thanks,

Bart.
