Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA679C2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbjILC2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjILC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:27:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1B13CC1A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:52:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-564af0ac494so3640291a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694483537; x=1695088337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwpiguO0UbnqrBVAgkTOyqOA0TbUDGD6mC+sN7KskI0=;
        b=SSR/t5MpaatJ+M7XunRAUauQ2DEx/YNGZ0dHkjXSA2jwlV4Scttg8nIv6Rgoizrt2q
         AlDTg5DOoZuxDPb9LN2UnfKGss8bNt2AMuSuG25qp2MGcrviteLs/5nrg3/7/iq0lBYA
         UkoOMM5TJ3zVzxA3rQ5OsldNN8D44E4zJVWO2hEteYhsq5QgTlWQ3MyXXsOxliW2wUqk
         OhGxiaQn1pppEcTRJZwF6bE84z7nG8HlpDU0quo2Z2ClIb9FmcNLuwJt2QGz2a+XDlSE
         yKvNAYHWtaAhFE08HuxxBl8pBB6ixK32BP9K89ud9E3LNQSDn1cFoCXwMvL3O1hdxn68
         5Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483537; x=1695088337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwpiguO0UbnqrBVAgkTOyqOA0TbUDGD6mC+sN7KskI0=;
        b=TicA+M6jO50YqEZRTSLgX1ltcW/HW95YOVtdsJbTlejv1NbdnQDXbbvm5pcDgY4dVd
         jfOg+W0pSceI0+Nyrq1fdqcHQ/qVt6SO4QPJhm1svDaIanQDnffkBssqVQkVWW5vocZU
         GXnlXR6gHJcWTXuZF4GuAJIiAJ7ibcaU1vs5oiH5tI54QChTvd7VD8m5YXQj87lA4bX5
         FPIdCYCo3zXNREVnmZIiOd500wJol4jUGGlg70aoub4OOYX7PHtfFd3OQ4ad4ADfR4Ku
         SwoWlNi5zsw+NHiOTxtWecalpOfVrYUYR+UWdMlLT3a4VBtPKCSCYdIbpEvH5BiVaAIs
         vkdA==
X-Gm-Message-State: AOJu0YzBTmJojEcrBKp57Tn0uZm9XlNdXeBohZUgTa3m2G2NThGQOPbc
        YUnBhXBGWoKJKstJ/SeS8wHKCg==
X-Google-Smtp-Source: AGHT+IF/LWkrzxBsF4AhQ5qgJsif8/E6lwiCAOPaiSUpQOXYS8By3op3abZdkkmIE99m2dH1kStZ6Q==
X-Received: by 2002:a05:6a21:47ca:b0:14b:f365:288a with SMTP id as10-20020a056a2147ca00b0014bf365288amr7505296pzc.47.1694483536714;
        Mon, 11 Sep 2023 18:52:16 -0700 (PDT)
Received: from leoy-huanghe ([98.98.49.243])
        by smtp.gmail.com with ESMTPSA id on10-20020a17090b1d0a00b0026b76edd607sm6414392pjb.15.2023.09.11.18.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 18:52:16 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:52:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Fix kernel timestamp handling
Message-ID: <20230912015204.GA122656@leoy-huanghe>
References: <20230910092413.53538-1-leo.yan@linaro.org>
 <04823db9-ed6c-0695-b9de-5a63bfa0aa5a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04823db9-ed6c-0695-b9de-5a63bfa0aa5a@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Sep 11, 2023 at 02:24:09PM +0100, James Clark wrote:

[...]

> > The current code can support both timestamp sources when synthesizing
> > samples. However, the decoding flow only relies on the hardware
> > timestamp.  If the hardware timestamp is zero, it becomes impossible to
> > decode the trace data.  Consequently, in this case, the commands below
> > won't output any samples:
> > 
> >     perf record -e cs_etm// --per-thread --timestamp -- ls
> >     perf script
> 
> Hi Leo,
> 
> I couldn't reproduce this issue, even when hard coding the hardware
> timestamp to zero in cs_etm_decoder__do_hard_timestamp() like this:
> 
>  converted_timestamp = 0;

I reproduced this issue on the Juno-r2 board, its "etm->has_virtual_ts"
is always false and Arm CoreSight timestamp packets are zeros.

Besides set "converted_timestamp = 0", it might need to hard code
"etm->has_virtual_ts" to false?

> I'm not sure why this would result in no samples being generated either,
> because we don't actually use the timestamps for anything yet [1]. We
> always wait until the very end of the file before decoding to ensure
> that all of the mmaps are loaded. And the timestamp is just assigned to
> the samples, but they shouldn't affect whether they are generated or not.
> 
> Unless there is something else I'm missing?

Let's review below code.

cs_etm__queue_first_cs_timestamp() retrieves trace data and decodes it,
and breaks the while loop until it find the timestamp is not zero or no
trace data is avaliable.  When the timestamp is always zero, the while
loop continues to drop the CoreSight trace data and don't synthesize
samples.

  cs_etm__queue_first_cs_timestamp()
  {
      ...

      while(1) {
          ret = cs_etm__get_data_block(etmq);
          if (ret <= 0)
              goto out;

          ret = cs_etm__decode_data_block(etmq);
          if (ret)
              goto out;

          cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
          /* We found a timestamp, no need to continue. */
          if (cs_timestamp)
              break;

          cs_etm__clear_all_packet_queues(etmq);
      }
  }

> Also, in cs_etm__queue_first_cs_timestamp(), cs_timestamp is used for
> sorting the decoding order between CPUs, but if the hardware timestamp
> is 0, then it's 0 on all trace.

Correct.

> So the sorting would be the same if you change that to be the kernel
> timestamp. They're all still the same
> static number, but just a different number (because we wait until the
> end of the file, 'latest_kernel_timestamp' is always the timestamp of
> the last AUX event in the file).

If we use the 'latest_kernel_timestamp' as timestamp, it's non-zero
timestamp rather than all timestamp '0'.  Yes, 'latest_kernel_timestamp'
is a coarse kernel timestamp which is shared by all trace data recorded
in the AUX event, though it's a static number, it can allow us to break
the while loop mentioned above.

I understand 'latest_kernel_timestamp' is inaccurate for sorting, but
as least now it exists in current code, quotes from util/cs-etm.c:

  /*
   * Record the latest kernel timestamp available in the header   
   * for samples so that synthesised samples occur from this point
   * onwards.
   */
  if (sample->time && (sample->time != (u64)-1))
        etm->latest_kernel_timestamp = sample->time;

> [1]: I still plan to change the decoding to decode up to the current
> time in the file, rather than waiting for the end of the file before
> starting. That way decoding trace when there were overlapping mmap
> regions in time will be more accurate.

Thanks for heading up.  I am not sure if I understand this correctly,
but seems to me it is a good thing to try for using overlapping mmap
events.

Just a side topic, if an Arm platform connect the Arm timer counter to
Arm CoreSight, and detect virtual timestamp is false (thus
etm->has_virtual_ts is 0).  I think this might happen on some legacy
platforms, can we use some ways to allow users to still use the Arm
CoreSight timestamp in this case?  E.g. we can force set
etm->has_virtual_ts to 1 when user specify the config
'-e cs_etm/timestamp/'.

Thanks,
Leo
