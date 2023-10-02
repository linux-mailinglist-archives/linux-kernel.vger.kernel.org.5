Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB77B5358
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjJBMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbjJBMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:38:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33675AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:38:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so21849354a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696250308; x=1696855108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0XqXLw8ahxmmww8UtIigy7ye9qRf79OVR4xxbkYhI4=;
        b=QnIyC0bv/pew6OLIdxi8ly1dChu5u/eBT3hFH35GH+eb8hpMOYyvsixm6OLaeWralM
         Sdw+w3Ue6XsvEYD4zxpLngNHa30DEO+qZUjUmI3rznH9toHiyG8DEIsSXiSckbANy4QM
         fxfVkEIomIbCa2AMAGNIIBU1IPcVype/u5A+39GBNmhjEhjpvZbQcJ08PGicEiQM6Bgz
         2PV6SvENuFXnusdKiCSUzq/z4S3KrushAzhTCMnc/oZnVMm7WE0N2w2zB514KzkbmUdR
         z5t43u7COaFr90auT7i109+cSfUNfqUv5rLeDIO1bzDH2RIhAhcowtWzTBgX93yCx45/
         88VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250308; x=1696855108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0XqXLw8ahxmmww8UtIigy7ye9qRf79OVR4xxbkYhI4=;
        b=cKCi2FFzTK0Rjs5+fm9PHv4cDq0OarNWxrbhy2ehozr/+OiSdzXa/CrPHMyVh/5Uai
         ao1UngImTNzSqLrOSctNcwHygGjizEfaDcDVWijzukEzAxInH69YBPlnmYRHTCCLcuBO
         agTWF7A9kHJuKrFfNKvrinEBUf65s330wtatnpqU5JWda63nvGiAUaX2F373uhj0VvdT
         Kb3RMjfV9x41uFdhJg8WovXZLlw9Oprq5ywL7Fai4/qlwZ3AquH5CrE2R0HZFQJque0d
         TXQ9n4GKYkQIJ0pUsXc7Oti47qe6/V1j5REbm+PuddbvuK9FkBZ9p7bUsLFQ2i/KdWgJ
         lDQg==
X-Gm-Message-State: AOJu0YyJEVnxXkGumRIFw5fYU5AYLIt5OXqK2f44yAz/5EPeY2kdWjkA
        TYF4T8pn5CmpgoqiAJ7bO6gobPAgXw==
X-Google-Smtp-Source: AGHT+IEZ8tO2t2SfkYjvyEe6qXK5pn5WcrxMxBnMMJ40agGz/HEfQaBjtUi6CwwOm6Dk5g9++AfVxQ==
X-Received: by 2002:a17:906:319b:b0:99d:e617:abeb with SMTP id 27-20020a170906319b00b0099de617abebmr10034329ejy.23.1696250308302;
        Mon, 02 Oct 2023 05:38:28 -0700 (PDT)
Received: from p183 ([46.53.251.182])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709067d4f00b009920a690cd9sm16955339ejp.59.2023.10.02.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:38:27 -0700 (PDT)
Date:   Mon, 2 Oct 2023 15:38:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com,
        swarupkotikalapudi@gmail.com
Subject: Re: + selftests-proc-add-proc-pid-statm-output-validation.patch
 added to mm-nonmm-unstable branch
Message-ID: <c1c55bdb-78cd-4b74-b9e5-2667dfdf9b2a@p183>
References: <20231001193740.B716AC433C7@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231001193740.B716AC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:37:40PM -0700, Andrew Morton wrote:
>      selftests-proc-add-proc-pid-statm-output-validation.patch

> Add /proc/${pid}/statm validation
> 
> /proc/$(pid)/statm output is expected to be:
>  "0 0 0 * 0 0 0\n"
> Here * can be any value
> 
> Read output of /proc/$(pid)/statm
> and compare length of output is
> equal or greater than expected output

> --- a/tools/testing/selftests/proc/proc-empty-vm.c~selftests-proc-add-proc-pid-statm-output-validation
> +++ a/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -303,6 +303,37 @@ static int test_proc_pid_smaps_rollup(pi
>  	}
>  }
>  
> +static const char g_statm[] = "0 0 0 * 0 0 0\n";

This is both unreliable and incorrect.

4th value is "end_code - start_code" when exec is done which could be
anything not 1-digit number (although unlikely).

Testing for strlen is simply too weak of a test.

> +static int test_proc_pid_statm(pid_t pid)
> +{
> +	char buf[4096];
> +
> +	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
> +
> +	int fd = open(buf, O_RDONLY);
> +
> +	if (fd == -1) {
> +		if (errno == ENOENT) {
> +			/*
> +			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
> +			 * it doesn't necessarily exist.
> +			 */
> +			return EXIT_SUCCESS;
> +		}
> +		perror("open /proc/${pid}/statm");
> +		return EXIT_FAILURE;
> +	} else {
> +		ssize_t rv = read(fd, buf, sizeof(buf));
> +
> +		close(fd);
> +		size_t len = strlen(g_statm);
> +
> +		assert(rv >= len);
> +		return EXIT_SUCCESS;
> +	}
> +}
> +
>  int main(void)
>  {
>  	int rv = EXIT_SUCCESS;
> @@ -389,11 +420,8 @@ int main(void)
>  		if (rv == EXIT_SUCCESS) {
>  			rv = test_proc_pid_smaps_rollup(pid);
>  		}
> -		/*
> -		 * TODO test /proc/${pid}/statm, task_statm()
> -		 * ->start_code, ->end_code aren't updated by munmap().
> -		 * Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
> -		 */
> +		if (rv == EXIT_SUCCESS)
> +			rv = test_proc_pid_statm(pid);
>  
>  		/* Cut the rope. */
