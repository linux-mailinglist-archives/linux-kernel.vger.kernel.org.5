Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C410C75B20F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjGTPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGTPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B52127;
        Thu, 20 Jul 2023 08:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7AAC61AF8;
        Thu, 20 Jul 2023 15:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0489C433C8;
        Thu, 20 Jul 2023 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689865781;
        bh=5g4Xx4ZaJyjCybAc+Ycb6LzHoCIJ7SMjln0ESw0bJD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r19XwKgtXby3Ms4qGJTTo3XZ+o9IirVbw/MM7o5lw3dl5xfDZPnKhj6mw2S/Mw69S
         bl3fnMpmB4uFoVhUeeZLy7Az65gmXzHfzryQCj8QI8Po/TOKPJuWC7pzyfjbbI7EhS
         yMKaODri/F/tHwyJWuF+DckxzJu4pwZ0depAUkI8b54AD9qYmtsyarAHlV4bGxcQd4
         KmEAhu+wPBI/svGA7TQ25C6s1F+FwcXXZ6XJYzrS0Ba8jcfyIGJU2LuHrfjHIOw8Qi
         ua4Zzgvr28maFlfW69ViTAEZ5CBauNSi9746bb0hf4Mw800LKfjxpRaYAULzzHswZS
         sb6O1Cg2UOipg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0FCA40516; Thu, 20 Jul 2023 12:09:37 -0300 (-03)
Date:   Thu, 20 Jul 2023 12:09:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] perf scripts python: Add trace end processing and
 PRODUCT and CATEGORIES information
Message-ID: <ZLlOMR9UjRFnCfS+@kernel.org>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
 <662239f70618982ef659362ae5729422f318db66.1689718662.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662239f70618982ef659362ae5729422f318db66.1689718662.git.anupnewsmail@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 19, 2023 at 04:20:08AM +0530, Anup Sharma escreveu:
> The final output will now be presented in JSON format following the Gecko
> profile structure. Additionally, the inclusion of PRODUCT allows easy retrieval
> of header information for UI.
> 
> Furthermore, CATEGORIES have been introduced to enable customization of
> kernel and user colors using input arguments. To facilitate this functionality,
> an argparse-based parser has been implemented.
> 
> Note that the implementation of threads will be addressed in subsequent commits."

It is failing here:

  [root@five ~]# perf script firefox-gecko-converter.py
  Traceback (most recent call last):
    File "/var/home/acme/libexec/perf-core/scripts/python/firefox-gecko-converter.py", line 202, in trace_end
      "threads": threads,
  NameError: name 'threads' is not defined. Did you mean: 'Thread'?
  Fatal Python error: handler_call_die: problem in Python trace event handler
  Python runtime state: initialized
  
  Current thread 0x00007fde43f98f40 (most recent call first):
    <no Python frame>
  
  Extension modules: perf_trace_context (total: 1)
  Aborted (core dumped)
  [root@five ~]#

We need to be able to test it at each changeset, not just at the end of
the patchkit, so please reorganize this so that running:

  perf script firefox-gecko-converter.py

After each patch works.

We need this to bisect problems, etc.

- Arnaldo
 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 64 ++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index d9b1ec18997a..a0218e2245f2 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -11,6 +11,8 @@
>  
>  import os
>  import sys
> +import json
> +import argparse
>  from dataclasses import dataclass, field
>  from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
>  
> @@ -30,6 +32,13 @@ Milliseconds = float
>  # start_time is intialiazed only once for the all event traces.
>  start_time = None
>  
> +# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/profile.js#L425
> +# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yellow for user space by default.
> +CATEGORIES = None
> +
> +# The product name is used by the profiler UI to show the Operating system and Processor.
> +PRODUCT = os.popen('uname -op').read().strip()
> +
>  # https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
>  class Frame(NamedTuple):
>  	string_id: StringID
> @@ -172,4 +181,57 @@ def process_event(param_dict: Dict) -> None:
>  # Trace_end runs at the end and will be used to aggregate
>  # the data into the final json object and print it out to stdout.
>  def trace_end() -> None:
> -	pass
> +	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
> +	gecko_profile_with_meta = {
> +		"meta": {
> +			"interval": 1,
> +			"processType": 0,
> +			"product": PRODUCT,
> +			"stackwalk": 1,
> +			"debug": 0,
> +			"gcpoison": 0,
> +			"asyncstack": 1,
> +			"startTime": start_time,
> +			"shutdownTime": None,
> +			"version": 24,
> +			"presymbolicated": True,
> +			"categories": CATEGORIES,
> +			"markerSchema": [],
> +			},
> +		"libs": [],
> +		"threads": threads,
> +		"processes": [],
> +		"pausedRanges": [],
> +	}
> +	json.dump(gecko_profile_with_meta, sys.stdout, indent=2)
> +
> +def main() -> None:
> +	global CATEGORIES
> +	parser = argparse.ArgumentParser(description="Convert perf.data to Firefox\'s Gecko Profile format")
> +
> +	# Add the command-line options
> +	# Colors must be defined according to this:
> +	# https://github.com/firefox-devtools/profiler/blob/50124adbfa488adba6e2674a8f2618cf34b59cd2/res/css/categories.css
> +	parser.add_argument('--user-color', default='yellow', help='Color for the User category')
> +	parser.add_argument('--kernel-color', default='orange', help='Color for the Kernel category')
> +	# Parse the command-line arguments
> +	args = parser.parse_args()
> +	# Access the values provided by the user
> +	user_color = args.user_color
> +	kernel_color = args.kernel_color
> +
> +	CATEGORIES = [
> +		{
> +			"name": 'User',
> +			"color": user_color,
> +			"subcategories": ['Other']
> +		},
> +		{
> +			"name": 'Kernel',
> +			"color": kernel_color,
> +			"subcategories": ['Other']
> +		},
> +	]
> +
> +if __name__ == '__main__':
> +    main()
> -- 
> 2.34.1
> 

-- 

- Arnaldo
