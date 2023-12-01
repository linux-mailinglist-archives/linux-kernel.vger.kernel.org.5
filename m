Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110E80030A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377418AbjLAFfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLAFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:34:58 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63191703;
        Thu, 30 Nov 2023 21:35:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4ADB95C01EE;
        Fri,  1 Dec 2023 00:35:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 01 Dec 2023 00:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701408901; x=1701495301; bh=GF
        bRhbSjB9oLO+LwKHE9kfWx3hJNKnD7jw8ytn4NBfc=; b=EvycvNBF7h8MZ6ztIM
        N1Yw39AfbJCGyaHfRtQ0veDNHIG/xx6lD3NYOexhB57vSyED6ehfQPo6f575fQIi
        cbFwa1Zho3FR2gIBaI/7qlf+7TybxpsFRBqk2eRLBrMykydGfrSF/wlmOTm9Lz3/
        ph0w1UlFz/Qq1yCKlRDdfYp2Jjk+2c+279sbr/vaBxU3mI9Iel+9B7sIgTB1+f/D
        4wclfbtzxBclbTy6sBBErBQydzdYKGRrZnzhaq1LuMqqIC9jkNVN999UHAtLhLUk
        X2GyMKEXJVlcQgaLCGDU51E2O4ojElNjOvYM0xpSnPlrkIqh3x90AuoBk4ZqdNKy
        m+KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701408901; x=1701495301; bh=GFbRhbSjB9oLO
        +LwKHE9kfWx3hJNKnD7jw8ytn4NBfc=; b=OnulShBVdt4nTEhF0acVUc1GBaps6
        XUmxAV6jfI5bDBbJ6RWpCWVob1mNNNwCAsD/DCst2pcogoKIXqqzsgtfiSC2rBD3
        Cqg/XYb5M5MnGzegr/xP9ywz8WyMCkLUuTSYiFkHkDGo3TJRiyfM9+R1HfSDffTl
        56onQbPYSTaFGeD+fF2zlHepE/nsVrjXeHystVR4LEKTnL7RTbCkaXfOo3YeVgk9
        7MhdQ4W4JwOIIRYg6Gx5UheX3adrObhvdfBUZ+/oTb1EnK3CMK7H48sQrcuz4+Q6
        Dt2SN5g3OUeP//THcWVZs1T1RAT77Of0ah8ym3T/oQ5y/+cGGppObAM1Q==
X-ME-Sender: <xms:hXBpZfjbiQJ2q5TYvTwMA8NH7jYsFSYEjq-DXvtdbpfzPahjWwAAbg>
    <xme:hXBpZcCU6RBDAhHY1rRzmhXntfd42M3MI6e0NdPjGfQBPB5hfvoYUqzcF8sxz6iiv
    QDpYrgiXpDjpL0Px2Y>
X-ME-Received: <xmr:hXBpZfEteadm9DhObeTPRuG-lVYCavoBNEmwM8TEzLFEdqR53NAt53FPLEXjSAPaQagy_E4RlqWg-XUqK8qqTHZMP1aA9hJvR5ux>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:hXBpZcSB7soGlszoalFU7aqqGh8dUx_GwSxz3AnzagYCPrZ5DC7Siw>
    <xmx:hXBpZcwcF4XxcwS-zQDsXprnK2pKTsd3IaERoffCTr5evbozaOaf7w>
    <xmx:hXBpZS4nrWO-LxShSqQLRkWHkdfFhV73Yk86g90is6KqJ0zgU7otaA>
    <xmx:hXBpZbqHjd1e5LngYLB0ofa0i5RcN2n_8EzQxC27ewNHaCgU8FpLiA>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 00:34:57 -0500 (EST)
Date:   Fri, 1 Dec 2023 15:34:52 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] selftests/hid: vmtest.sh: allow finer control on
 the build steps
Message-ID: <20231201053452.GA625212@quokka>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
 <20231129-wip-selftests-v1-2-ba15a1fe1b0d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-wip-selftests-v1-2-ba15a1fe1b0d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:24:27PM +0100, Benjamin Tissoires wrote:
> vmtest.sh works great for a one shot test, but not so much for CI where
> I want to build (with different configs) the bzImage in a separate
> job than the one I am running it.
> 
> Add a "build_only" option to specify whether we need to boot the currently
> built kernel in the vm.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/vmtest.sh | 42 ++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
> index 301b4e162336..52ada972833b 100755
> --- a/tools/testing/selftests/hid/vmtest.sh
> +++ b/tools/testing/selftests/hid/vmtest.sh
> @@ -32,7 +32,7 @@ DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS
>  usage()
>  {
>  	cat <<EOF
> -Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
> +Usage: $0 [-j N] [-s] [-b] [-d <output_dir>] -- [<command>]
>  
>  <command> is the command you would normally run when you are in
>  the source kernel direcory. e.g:
> @@ -55,6 +55,7 @@ Options:
>  
>  	-u)		Update the boot2container script to a newer version.
>  	-d)		Update the output directory (default: ${OUTPUT_DIR})
> +	-b)		Run the only build steps for the kernel and the selftests

typo: "run only the"

Cheers,
  Peter


>  	-j)		Number of jobs for compilation, similar to -j in make
>  			(default: ${NUM_COMPILE_JOBS})
>  	-s)		Instead of powering off the VM, start an interactive
> @@ -191,8 +192,9 @@ main()
>  	local command="${DEFAULT_COMMAND}"
>  	local update_b2c="no"
>  	local debug_shell="no"
> +	local build_only="no"
>  
> -	while getopts ':hsud:j:' opt; do
> +	while getopts ':hsud:j:b' opt; do
>  		case ${opt} in
>  		u)
>  			update_b2c="yes"
> @@ -207,6 +209,9 @@ main()
>  			command="/bin/sh"
>  			debug_shell="yes"
>  			;;
> +		b)
> +			build_only="yes"
> +			;;
>  		h)
>  			usage
>  			exit 0
> @@ -226,8 +231,7 @@ main()
>  	shift $((OPTIND -1))
>  
>  	# trap 'catch "$?"' EXIT
> -
> -	if [[ "${debug_shell}" == "no" ]]; then
> +	if [[ "${build_only}" == "no" && "${debug_shell}" == "no" ]]; then
>  		if [[ $# -eq 0 ]]; then
>  			echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
>  		else
> @@ -267,24 +271,26 @@ main()
>  	update_kconfig "${kernel_checkout}" "${kconfig_file}"
>  
>  	recompile_kernel "${kernel_checkout}" "${make_command}"
> +	update_selftests "${kernel_checkout}" "${make_command}"
>  
> -	if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
> -		echo "vm2c script not found in ${b2c}"
> -		update_b2c="yes"
> -	fi
> +	if [[ "${build_only}" == "no" ]]; then
> +		if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
> +			echo "vm2c script not found in ${b2c}"
> +			update_b2c="yes"
> +		fi
>  
> -	if [[ "${update_b2c}" == "yes" ]]; then
> -		download $B2C_URL $b2c
> -		chmod +x $b2c
> -	fi
> +		if [[ "${update_b2c}" == "yes" ]]; then
> +			download $B2C_URL $b2c
> +			chmod +x $b2c
> +		fi
>  
> -	update_selftests "${kernel_checkout}" "${make_command}"
> -	run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
> -	if [[ "${debug_shell}" != "yes" ]]; then
> -		echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
> -	fi
> +		run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
> +		if [[ "${debug_shell}" != "yes" ]]; then
> +			echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
> +		fi
>  
> -	exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
> +		exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
> +	fi
>  }
>  
>  main "$@"
> 
> -- 
> 2.41.0
> 
