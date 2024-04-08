Return-Path: <linux-kernel+bounces-135486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539289C687
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D0B1C21B23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D085631;
	Mon,  8 Apr 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBNzVomG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F38529C;
	Mon,  8 Apr 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585563; cv=none; b=lOCFA17nXDab7mFGBZo/51PEMN3utEYnDba1soMqm5PgVdJ26+juQn+4fXTJ7S2HNyiHPcFg2rSSXcIbmM5n+ABnDwwSBkHonzqxuxWVS6L4mrQgKZXGa3KD0Q/zRX4o2JVuXne112plTRupBxj+gZDmu4olvN/wt0Ka8w8Ed4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585563; c=relaxed/simple;
	bh=735VKE0QpPj2KT97mnZk0BfDnVMAsmCzbVSOSWMgkEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eonKDhcs7hh3NtCa0MDlyEzKApoD72BR8fgTt5+Xfdv1EdCdeRjzJzbNoXOIPzW5yZAlojXhs0DmwdVZeYLMT9EBooIiPBKQfoIgHklN6xc3pwIppj+p/4WzzOXWeCLOQddKZfSnd5fHD92Qa2ZQHUwwDeBI4se3IeebzwuGKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBNzVomG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48A8C433C7;
	Mon,  8 Apr 2024 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585561;
	bh=735VKE0QpPj2KT97mnZk0BfDnVMAsmCzbVSOSWMgkEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBNzVomG1P+7CADMc8m84bXy7stsHg6X5VbYRdKCdryHwxDTNgiMC2mFWilCTIVpF
	 bJvBU7fH9QSRWrOC+CVjVzBRx4RmylTw8nE1xK2lm9+x+CmGX7zVNPBvc6wzy/Wf9s
	 k2Aq4EfSvo6wWQQoWVT1C5CkPVz9s/NtkddRZjvAgdQk0S0b4tN9/kVTuW7y0EsVZq
	 xBq3fsB3Do8fEXGzckImf7+UgOnKMD1JssTjjIbxUnv2/cH8+FNct3n2gRraAJw71X
	 BvJsEIAoqf5L2lLNLH0mB3D2emXgQkPoXSHcbaYVmvbJe9jR1NUkU9D3rLx64hY3be
	 a52uvyIywm9Ag==
Date: Mon, 8 Apr 2024 11:12:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Display number of remaining tests
Message-ID: <ZhP7VBvlSPrJKDP6@x1>
References: <20240405070931.1231245-1-irogers@google.com>
 <20240405070931.1231245-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405070931.1231245-2-irogers@google.com>

On Fri, Apr 05, 2024 at 12:09:31AM -0700, Ian Rogers wrote:
> Before polling or sleeping to wait for a test to complete, print out
> ": Running (<num> remaining)" where the number of remaining tests is
> determined by iterating over the remaining tests and seeing which
> return true for check_if_command_finished. After the delay, erase the
> line and either update it with the new number of remaining tests, or
> print the test's result. This allows a user to know a test is running
> and in parallel mode (default) how many of the tests are waiting to
> complete. If color mode is disabled then avoid displaying the
> "Running" message.

Tested and applied, great improvement!

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
>  tools/perf/util/color.h         |  1 +
>  2 files changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 73f53b02f733..15b8e8e32749 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -238,7 +238,10 @@ static int run_test_child(struct child_process *process)
>  	return -err;
>  }
>  
> -static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
> +#define TEST_RUNNING -3
> +
> +static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
> +			     int remaining)
>  {
>  	if (has_subtests(t)) {
>  		int subw = width > 2 ? width - 2 : width;
> @@ -248,6 +251,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
>  		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
>  
>  	switch (result) {
> +	case TEST_RUNNING:
> +		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d remaining)\n", remaining);
> +		break;
>  	case TEST_OK:
>  		pr_info(" Ok\n");
>  		break;
> @@ -269,13 +275,15 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
>  	return 0;
>  }
>  
> -static int finish_test(struct child_test *child_test, int width)
> +static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
> +		       int width)
>  {
> +	struct child_test *child_test = child_tests[running_test];
>  	struct test_suite *t = child_test->test;
>  	int i = child_test->test_num;
>  	int subi = child_test->subtest;
>  	int err = child_test->process.err;
> -	bool err_done = err <= 0;
> +	bool err_done = false;
>  	struct strbuf err_output = STRBUF_INIT;
>  	int ret;
>  
> @@ -290,7 +298,7 @@ static int finish_test(struct child_test *child_test, int width)
>  	 * Busy loop reading from the child's stdout/stderr that are set to be
>  	 * non-blocking until EOF.
>  	 */
> -	if (!err_done)
> +	if (err > 0)
>  		fcntl(err, F_SETFL, O_NONBLOCK);
>  	if (verbose > 1) {
>  		if (has_subtests(t))
> @@ -304,29 +312,48 @@ static int finish_test(struct child_test *child_test, int width)
>  			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
>  			},
>  		};
> -		char buf[512];
> -		ssize_t len;
> -
> -		/* Poll to avoid excessive spinning, timeout set for 100ms. */
> -		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
> -		if (!err_done && pfds[0].revents) {
> -			errno = 0;
> -			len = read(err, buf, sizeof(buf) - 1);
> -
> -			if (len <= 0) {
> -				err_done = errno != EAGAIN;
> -			} else {
> -				buf[len] = '\0';
> -				if (verbose > 1)
> -					fprintf(stdout, "%s", buf);
> -				else
> +		if (perf_use_color_default) {
> +			int tests_in_progress = running_test;
> +
> +			for (int y = running_test; y < child_test_num; y++) {
> +				if (check_if_command_finished(&child_tests[y]->process))
> +					tests_in_progress++;
> +			}
> +			print_test_result(t, i, subi, TEST_RUNNING, width,
> +					  child_test_num - tests_in_progress);
> +		}
> +
> +		err_done = true;
> +		if (err <= 0) {
> +			/* No child stderr to poll, sleep for 10ms for child to complete. */
> +			usleep(10 * 1000);
> +		} else {
> +			/* Poll to avoid excessive spinning, timeout set for 100ms. */
> +			poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
> +			if (pfds[0].revents) {
> +				char buf[512];
> +				ssize_t len;
> +
> +				len = read(err, buf, sizeof(buf) - 1);
> +
> +				if (len > 0) {
> +					err_done = false;
> +					buf[len] = '\0';
>  					strbuf_addstr(&err_output, buf);
> +				}
>  			}
>  		}
> +		if (err_done)
> +			err_done = check_if_command_finished(&child_test->process);
> +
> +		if (perf_use_color_default) {
> +			/* Erase "Running (.. remaining)" line printed before poll/sleep. */
> +			fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
> +		}
>  	}
>  	/* Clean up child process. */
>  	ret = finish_command(&child_test->process);
> -	if (verbose == 1 && ret == TEST_FAIL) {
> +	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL)) {
>  		/* Add header for test that was skipped above. */
>  		if (has_subtests(t))
>  			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
> @@ -335,7 +362,7 @@ static int finish_test(struct child_test *child_test, int width)
>  		fprintf(stderr, "%s", err_output.buf);
>  	}
>  	strbuf_release(&err_output);
> -	print_test_result(t, i, subi, ret, width);
> +	print_test_result(t, i, subi, ret, width, /*remaining=*/0);
>  	if (err > 0)
>  		close(err);
>  	return 0;
> @@ -351,7 +378,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
>  		pr_debug("--- start ---\n");
>  		err = test_function(test, subi)(test, subi);
>  		pr_debug("---- end ----\n");
> -		print_test_result(test, i, subi, err, width);
> +		print_test_result(test, i, subi, err, width, /*remaining=*/0);
>  		return 0;
>  	}
>  
> @@ -376,7 +403,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
>  	err = start_command(&(*child)->process);
>  	if (err || !sequential)
>  		return  err;
> -	return finish_test(*child, width);
> +	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
>  }
>  
>  #define for_each_test(j, k, t)					\
> @@ -461,7 +488,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  	}
>  	for (i = 0; i < child_test_num; i++) {
>  		if (!sequential) {
> -			int ret  = finish_test(child_tests[i], width);
> +			int ret  = finish_test(child_tests, i, child_test_num, width);
>  
>  			if (ret)
>  				return ret;
> diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
> index 01f7bed21c9b..4b9f8d5d4439 100644
> --- a/tools/perf/util/color.h
> +++ b/tools/perf/util/color.h
> @@ -22,6 +22,7 @@
>  #define MIN_GREEN	0.5
>  #define MIN_RED		5.0
>  
> +#define PERF_COLOR_DELETE_LINE	"\033[A\33[2K\r"
>  /*
>   * This variable stores the value of color.ui
>   */
> -- 
> 2.44.0.478.gd926399ef9-goog

