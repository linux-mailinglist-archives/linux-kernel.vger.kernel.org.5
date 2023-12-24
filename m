Return-Path: <linux-kernel+bounces-10662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC881D860
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9B4282689
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13A2116;
	Sun, 24 Dec 2023 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olUzveYL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786F20F5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so221227739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703406819; x=1704011619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rO7WgIPdNcnqWQpaudC4tS6W5dWb0hVk4elNmQeiAV8=;
        b=olUzveYL3r35YTE26G3Zj4/GB0nt+zCYqwDBpxnT+5Joi+YfHAG7ssEvTo9cG9DA1H
         GqpDefuyAVrM9t9ZUHImei/9ETq3olMIQLDWXnLCJ/INmWSmMgFR2eBm3ArNY2oPAyOL
         /hPCL5mhYvgjFMant+OsWR1vf9tzZ4DM8uxPhcxk1o0ohxhOpomjjfSVS0AwHRYHzxE3
         Uicbx7wSngIIjOn7ybjkcaxH/NCtbtelsSPz9cYblospIka3ZtUX5N/hq27p7AywuTmR
         LeU678AXrPbqzR1nlzL5O7itSmMQI9DjTgLnWOOM+u4SZf3tdvtDsQnVLsMbkD9zX81T
         Z55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703406819; x=1704011619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO7WgIPdNcnqWQpaudC4tS6W5dWb0hVk4elNmQeiAV8=;
        b=IQpYZynKAgY0MVLT0zKCdA82Fm1gAD7Xg21AKRCm2Kf+s4gw8kCCE50FuGjGHSshrc
         MGq995IXHgvy6JYzD3b/jv1UydffSLq092LeDoLSL4lJQb6rJcOtVC3vlJk4CZ1BVbU4
         PSgtdS1KUfpA3J5+b84S2p8TJCwUYG/RhoPQeTZTPZmSCYUrlyu0tfI1GbYLFBnuQ1Cg
         wJxfuWFHI6CSyrLqhTXGPsczhVU/pKS7b8+/cg2cRA4gsJI7eZV1un5Foiz/4EhgXemt
         dk76PB2LDy+dyHTSXpQqD7jul7bNyUE+T7/F4uU6KB7Wlby0Wb1ducdP2g5Z2TF0jBms
         Ewog==
X-Gm-Message-State: AOJu0YxmW+B+SSbyA2VAwx0MWGOpzVbcpTVgcvaVtOWMiSHJp8Q1IWUv
	xI2j/TAxEKn3o17a+ymnm6Z7aI1DmKFArQ==
X-Google-Smtp-Source: AGHT+IF8QP7yXui7EAHR1MbphUykeltelj4BQc2aY1WH7AjvwFE/uixP6mcbTfC2JZo3iDMfZxNieg==
X-Received: by 2002:a05:6e02:19cd:b0:35f:ee15:688d with SMTP id r13-20020a056e0219cd00b0035fee15688dmr3742373ill.104.1703406818815;
        Sun, 24 Dec 2023 00:33:38 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001d3d8c04331sm6154915pld.64.2023.12.24.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 00:33:38 -0800 (PST)
Date: Sun, 24 Dec 2023 16:33:32 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, suzuki.poulose@arm.com,
	mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, al.grant@arm.com,
	mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
Subject: Re: [PATCH 1/3] perf scripts python: arm-cs-trace-disasm.py: print
 dso base address
Message-ID: <20231224083332.GB13521@leoy-huanghe.lan>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20231214123304.34087-2-tianruidong@linux.alibaba.com>
 <912a39f4-025e-26a1-7786-091fa211f293@arm.com>
 <6177beec-f140-44aa-b534-182cd4b0a988@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6177beec-f140-44aa-b534-182cd4b0a988@linux.alibaba.com>

Hi Ruidong,

On Fri, Dec 22, 2023 at 03:29:18PM +0800, Ruidong Tian wrote:

[...]

> > Although it's also not that clear what this is useful for, given that
> > all the other output is relative too? Maybe you could add an example to
> > the commit message, even if it's just for debugging. Would an option
> > that turned _all_ the output into virtual addresses not be more useful?
>
> I want to use arm-cs-trace-disasm.py output associate with PMU and SPE data
> to explore more CPU performance info, all the PMU/SPE/Coresight informations
> generated by `perf report` and `perf script` include virtual address, so i
> want this script do the same thing.

I think James' suggestion is valid for replacing all offsets with
virtual addresses, in addition to introducing a new option.

Below change works well at my side. Hope this is helpful.

  diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
  index de58991c78bb..6c94ff2287cd 100755
  --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
  +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
  @@ -36,7 +36,10 @@ option_list = [
                      help="Set path to objdump executable file"),
          make_option("-v", "--verbose", dest="verbose",
                      action="store_true", default=False,
  -                   help="Enable debugging log")
  +                   help="Enable debugging log"),
  +       make_option("-a", "--vaddr", dest="vaddr",
  +                   action="store_true", default=False,
  +                   help="Enable virtual address")
   ]
  
   parser = OptionParser(option_list=option_list)
  @@ -108,6 +111,14 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
                          m = disasm_re.search(line)
                          if m is None:
                                  continue
  +
  +               # Replace offset with virtual address
  +               if (options.vaddr == True):
  +                       offset = re.search(r"^\s*([0-9a-fA-F]+)", line).group()
  +                       if offset:
  +                               virt_addr = dso_start + int(offset, 16)
  +                               line = line.replace(offset.lstrip(), "0x%016x" % virt_addr)
  +
                  print("\t" + line)
  
   def print_sample(sample):

Thanks,
Leo

