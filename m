Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E897548E3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGONxh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 Jul 2023 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGONxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:53:36 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491710DC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:53:34 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 694E8B00B3;
        Sat, 15 Jul 2023 13:53:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id D92D42F;
        Sat, 15 Jul 2023 13:53:30 +0000 (UTC)
Message-ID: <0712b0d8d777777a3f91f5c394f410e3196a80ac.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore /dev/null being added for file path
 checks
From:   Joe Perches <joe@perches.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 15 Jul 2023 06:53:29 -0700
In-Reply-To: <20230715095804.14258-1-jonas.gorski@gmail.com>
References: <20230715095804.14258-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 3qubbopraxnsau9ojq5d5ha6ozoddj7c
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D92D42F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19aW7+Dk55rZqvmeUJ/YB9Nn4IyEKfTUmE=
X-HE-Tag: 1689429210-615544
X-HE-Meta: U2FsdGVkX19nU/322H6IoZTvePmvKucRTn1h5xdiU0u0aTKzO9drHgyqmmc3KyIFrEtvj3QpowBQQ64gvVwFbOweRw0pVDdgtn3ofD7OXDXcxzCOkR+1EabavawhNC40skHv4H/ktptzKNonY6PeioYVWWDGm6KfAqTSR7cKqcXBH0rhdJ+tRftBQXdsFbo2HG+sCdeE3QSiQk2MIWjTGAJmo4/c50N4//4pUSNB/VKTbB2gaot3bjCaB7jcte+6BeCz9jXezyRdeBQvGdQOOOJNKiTYz9updEm3LqJuWSSyoy1ehJGSwn8hk9+eSbLjs8h8abzZfXUjlKVrm90p1KgqOV+IUT2Q
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-07-15 at 11:58 +0200, Jonas Gorski wrote:
> In e.g. schema to yaml conversion patches, a file may be deleted,
> causing checkpatch in strict mode to complain about files outside of the
> bindings directory being modified:
> 
>   ./scripts/checkpatch.pl --strict --showfile 0001-dt-bindings-spi-convert-spi-brcm63xx.txt-to-YAML.patch

Please send this patch file

>   dev/null:72: WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>   total: 0 errors, 1 warnings, 0 checks, 79 lines checked
> 
> Since this isn't a real file, skip any further checks based on the
> file's location.
> 
> Fixes: 133712a2ec84 ("checkpatch: DT bindings should be a separate patch")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>


> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 880fde13d9b8..30de47909460 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2856,6 +2856,12 @@ sub process {
>  			$realfile =~ s@^([^/]*)/@@ if (!$file);
>  			$in_commit_log = 0;
>  
> +			# "/dev/null" being added means a file was actually
> +			# deleted, no need for further file location checks
> +			if ($line eq "+++ /dev/null") {
> +				next;
> +			}
> +
>  			$p1_prefix = $1;
>  			if (!$file && $tree && $p1_prefix ne '' &&
>  			    -e "$root/$p1_prefix") {

