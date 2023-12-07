Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E808090E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443777AbjLGS4V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 13:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjLGS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:56:19 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05E1703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:56:25 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id C679B401F9;
        Thu,  7 Dec 2023 18:56:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 3B73B1A;
        Thu,  7 Dec 2023 18:56:18 +0000 (UTC)
Message-ID: <c2138d24bcaec664e9239e6e1bade6116db04027.camel@perches.com>
Subject: Re: [PATCH v3 01/13] scripts: checkpatch: Add __aligned to the list
 of attribute notes
From:   Joe Perches <joe@perches.com>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Dec 2023 10:56:17 -0800
In-Reply-To: <e8d5343a0a6b5d976873d3896ad9ab0c88505c6d.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
         <e8d5343a0a6b5d976873d3896ad9ab0c88505c6d.1701971344.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3B73B1A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: uc1ruosambyhhk1jej9gqi9e1oaeh155
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX188AVrchA8Q6aSf2ubwLQwytSUKZZesA8Q=
X-HE-Tag: 1701975378-987312
X-HE-Meta: U2FsdGVkX1+CjSoSgA4ZE8tPllT47ZdAoJmXNslwU/RdfB9ysc18qu5HDv/6UxcleLmTGK/xkn9Crk4a0B67WkHfmt5oOKGXXZandu+E/HzSP+oWthr6rm6yzoYJmAA7i5VALJXVA3n4Y36OKkM62KcwWVxY4XGB6CeA9rYvioQ1Gl6DVSBzE8NuJGpwpv74aCXVlhLG0WnOdaU5RE8Kqwz2ja6pUMPtmiGEB2xR6/EOLrBPmq/zTGR5nqcJh6DYGk1/Iv7YN85Ep1EuFNhKNfPeZ9kZgiEqWOP/3OC7YR5LfPStgN5p1Rpq+gvkEg+5CbJINLb08STI2YpAOkWEv7WNHylca8Hiyg3x4z2SgBS+tvm0qIoZgggs5kBujoLD
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-12-07 at 15:37 -0300, Marcelo Schmitt wrote:
> Checkpatch presumes attributes marked with __aligned(alignment) are part
> of a function declaration and throws a warning stating that those
> compiler attributes should have an identifier name which is not correct.
> Add __aligned compiler attributes to the list of attribute notes
> so they don't cause warnings anymore.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> The patch that would trigger the mentioned checkpatch warning in this series is
> patch number 12 (iio: adc: Add support for AD7091R-8).
> 
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..e6773ae0ad08 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -512,6 +512,7 @@ our $Attribute	= qr{
>  			__ro_after_init|
>  			__kprobes|
>  			$InitAttribute|
> +			__aligned|

__aligned takes an argument so I think there needs
to have something like the use of __alloc_size below
this addition
	__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)

maybe

			__aligned\s*\([^\)]*\)

though even that would work well with most uses it
would not work with things like

drivers/crypto/inside-secure/safexcel_hash.c:   u8 cache[HASH_CACHE_SIZE] __aligned(sizeof(u32));

