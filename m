Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D857DD17C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbjJaQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbjJaQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:23:42 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49522A6;
        Tue, 31 Oct 2023 09:23:40 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bcf83a8f6cso20792a12.2;
        Tue, 31 Oct 2023 09:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769420; x=1699374220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBWUu0tjqfzQQcXAkjZScnGhPDhYF0A6SWvhtDvbljg=;
        b=e5/0B01YuUwb7dshMbzA+LN1JbglN6ZXHnSln0m/7bciiMynhBR+4CFUghL3B/4AcP
         IdLxaDWkZsvzYO1q2taB3AUQ8rw1epZcYrtcfPzUENkhBRD7Ov+YFiIGjbhotaZ1u2ii
         039/rNleRCkIdCxcmtLf3slTpdlVkkatuq0uZjpuLTWbPAfwpIKwnHWhHHopDa408hrK
         3i3PR5OKi7F+O2NT5lRYhgE0YRq5HI38elxvTISd8LU2/hukHhOUElJTXDi4KhSWzLur
         hIRWpbbxYS1JsXoortwrphx7V6iaDOHAA3TQzOd0DNSrHeCDNDWkfM7HN0rjZ7TuLYIy
         7OKg==
X-Gm-Message-State: AOJu0YxEIqeFnDRCe5g6jVvsczEhwTNwrBqAiNPh2axgEmHdjbwsgLdw
        njBcZr3ky25RPcK/f/zO3yr07DyWjyg=
X-Google-Smtp-Source: AGHT+IEiqyEA5Jo7RoN3JI58BhuOtNEOxzgSgsyGJ3lhVwY14vx0QWk1I5bxtuTa8wFF2fi+BzbNVQ==
X-Received: by 2002:a17:902:f68f:b0:1cc:25b7:e30d with SMTP id l15-20020a170902f68f00b001cc25b7e30dmr10024790plg.60.1698769419503;
        Tue, 31 Oct 2023 09:23:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3a79:8603:fbab:a9fd? ([2620:15c:211:201:3a79:8603:fbab:a9fd])
        by smtp.gmail.com with ESMTPSA id ik22-20020a170902ab1600b001c5eb2c4d8csm1560142plb.160.2023.10.31.09.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:23:38 -0700 (PDT)
Message-ID: <fe022e5f-e7da-480b-9d1c-ce2a6388d768@acm.org>
Date:   Tue, 31 Oct 2023 09:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: ufs-sysfs: Expose UFS power info
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1698745992-5699-1-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1698745992-5699-1-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 02:53, Can Guo wrote:
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/mode
> +What:		/sys/bus/platform/devices/*.ufs/power_info/mode
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the UniPro power mode of UFS link:
> +		==  ====================================================
> +		1   FAST_MODE
> +		2   SLOW_MODE
> +		4   FASTAUTO_MODE
> +		5   SLOWAUTO_MODE
> +		==  ====================================================
> +
> +		The file is read only.

For this attribute and the attributes below, shouldn't these be exported
as text instead of as numbers? Shell scripts that read and use these
attributes will be much easier to read if these attributes are changed
from numeric into a textual.

Thanks,

Bart.
