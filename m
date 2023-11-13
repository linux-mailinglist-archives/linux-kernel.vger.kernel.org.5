Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F187E971F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 08:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjKMHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 02:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKMHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 02:44:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429710D1;
        Sun, 12 Nov 2023 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699861464; x=1731397464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AFfCD1YyiU2ZTy2YU+nVobKc5Z+t2ndgqqB/PxSqrUI=;
  b=dG86i2z2+JdxiXuWg3yma7G/x6YsbDP69YAfJs1vsvnnvOdsw8YDMP7f
   w1YLDa++lK1b3gNMizEwFDfjL/8NG8jrIuU3mSDgziZaH0ZgloxyFhSKk
   gD07NvonAW0DkDfsPBZlzya+wzAUNBmhdMKYeT0Dd/6PDi/OGCDNmtiJs
   yj+rvD5fhWZw1dCMaF54BUZ6FCR7UJXAywyt7oXAmX5xj/AEJxBA9naTG
   y1+XaR/v3blcq53HuO1mQpmKjUxT9yEO//tGeuoIXDEsRUAAtqm3oEiTn
   eGNTvtyB2SPIKoF/IvwqlzuimZjoKo3b86uF268kEHaDAXnD7yGDPUA3U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="370591247"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="370591247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 23:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="12024301"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.43.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 23:44:20 -0800
Message-ID: <5a909795-bd93-4c33-9de4-729f45182427@intel.com>
Date:   Mon, 13 Nov 2023 09:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script python: Fail check on dynamic allocation.
To:     Paran Lee <p4ranlee@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com, honggyu.kp@gmail.com
References: <20231112071446.7811-1-p4ranlee@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231112071446.7811-1-p4ranlee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 09:14, Paran Lee wrote:
> There is Ommitted PyList_New() Fail check
> and set_regs_in_dict(), python_start_script()
> dynamic allocation checking.
> 
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>

Please ensure patches compile before submitting.  Also run checkpatch
and fix any errors, and consider fixing warnings and checks.  Have a look
at checkpatch --strict also.

> ---
>  .../scripting-engines/trace-event-python.c     | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 94312741443a..0847c50d4601 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -353,6 +353,8 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
>  
>  	if (is_array) {
>  		list = PyList_New(field->arraylen);
> +		if (!list)
> +			Py_FatalError("couldn't create Python list");
>  		item_size = field->size / field->arraylen;
>  		n_items = field->arraylen;
>  	} else {
> @@ -754,7 +756,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
>  	}
>  }
>  
> -static void set_regs_in_dict(PyObject *dict,
> +static int set_regs_in_dict(PyObject *dict,
>  			     struct perf_sample *sample,
>  			     struct evsel *evsel)
>  {
> @@ -770,6 +772,9 @@ static void set_regs_in_dict(PyObject *dict,
>  	 */
>  	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
>  	char *bf = malloc(size);
> +	if (!bf)
> +		return -1;
> +	}
>  
>  	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
>  
> @@ -781,6 +786,8 @@ static void set_regs_in_dict(PyObject *dict,
>  	pydict_set_item_string_decref(dict, "uregs",
>  			_PyUnicode_FromString(bf));
>  	free(bf);
> +
> +	return 0;
>  }
>  
>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
> @@ -920,7 +927,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
>  	}
>  
> -	set_regs_in_dict(dict, sample, evsel);
> +	if (!set_regs_in_dict(dict, sample, evsel))
> +		Py_FatalError("Failed to setting regs in dict");
>  
>  	return dict;
>  }
> @@ -1918,12 +1926,18 @@ static int python_start_script(const char *script, int argc, const char **argv,
>  	scripting_context->session = session;
>  #if PY_MAJOR_VERSION < 3
>  	command_line = malloc((argc + 1) * sizeof(const char *));
> +	if(!command_line) {
> +		return -1;
> +	}
>  	command_line[0] = script;
>  	for (i = 1; i < argc + 1; i++)
>  		command_line[i] = argv[i - 1];
>  	PyImport_AppendInittab(name, initperf_trace_context);
>  #else
>  	command_line = malloc((argc + 1) * sizeof(wchar_t *));
> +	if(!command_line) {
> +		return -1;
> +	}
>  	command_line[0] = Py_DecodeLocale(script, NULL);
>  	for (i = 1; i < argc + 1; i++)
>  		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);

