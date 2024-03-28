Return-Path: <linux-kernel+bounces-122945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4CE88FFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C070B1F23D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373307FBD0;
	Thu, 28 Mar 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o6lBdpeh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B17E767;
	Thu, 28 Mar 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631828; cv=none; b=YhbPRGkqH6rzdZuEnkRYljxE1L+Kfdh00GWfcX+d42im+7O0eQMuGzX0JBNcnW9h4XsAvFMkWldDTIwAUgNBu7COFpD8iGPqj23DThNF93WlRczs4v2zv313xYjuIc014lh42FP1+zjMss3KvxWkURJtIMblbJO4vOdopEgfl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631828; c=relaxed/simple;
	bh=lFcer5cRuCHvRqbG9870yYLfTMMeSNIr8kl344emETU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+KiKxaQKZhMGm5eNoPCU9qidhXUDDeP8UIWWsjtHjaKN0MO0+9xuzLgpsQGzmh052ez1o3Y4MuL7+41Jo6LxPRlNlAgQBRWn9SFuQ25CXHTchFNrEWYoGwAv4pVzjexV531DR/Jvet3tVRkanTYxf/Zf+gJWFJGc4Ot3KAJzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o6lBdpeh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711631825;
	bh=lFcer5cRuCHvRqbG9870yYLfTMMeSNIr8kl344emETU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o6lBdpehY4+0IlVQF14iOGGVI/6vTUidQn2ngxmgZGPwYqMsSANmzdbX5tG8qUuTI
	 nPEEhxhhVpQsrwAhFi+k6Lq7ZeUICcs/paZ66e6clYtcRw3R566RfvTuo122X/o3zH
	 1xOdxBPtuWOzJHP4sra+M0wcdiDyj0CtJlmOQsQNG5Ec/9eFpmAkpcTQ+Fd2MQksqX
	 J2VhQq7NgYeoBcAv4InrpKAQfN1KDp02nFoZGv5vtTHBAdvh1oNYPY3dwCZo6KgdWN
	 wirtwe9KReNYY0gvP9mwHiSFqDz46IXnMwG7I6W9hDCBkA+NmUj2gi/5PA+ipTkI6U
	 PR8TTUgkw05Ag==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE8433780629;
	Thu, 28 Mar 2024 13:17:03 +0000 (UTC)
Message-ID: <c0cc12e6-4f71-449c-b614-a8fbfb4aaa80@collabora.com>
Date: Thu, 28 Mar 2024 10:17:00 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] gitlab-ci: Let project define runner using
 environment variables
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240327013055.139494-2-leobras@redhat.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240327013055.139494-2-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leonardo,

Thanks for the patch.

On 26/03/2024 22:30, Leonardo Bras wrote:
> Currently it's not possible to select which runner will handle a pipeline
> without changing the codebase.
> 
> Add CI_TAGS environment variable, which can be used to select a runner
> either from a commit message, or directly from Gitlab interface.
> 
> Also add Documentation for this variable.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
> 
> This patch goes on top on a previous patchset sent by Helen:
> https://lore.kernel.org/all/20240228225527.1052240-1-helen.koike@collabora.com/
> 
> With this patch I could run CI with gitlab.com runners, by setting
> CI_TAGS=saas-linux-medium-amd64
> 
> The result of this pipeline can be seen in:
> https://gitlab.com/linux-kernel/linux/-/pipelines/1228999646
> 
>   Documentation/ci/gitlab-ci/gitlab-ci.rst | 5 +++++
>   ci/gitlab-ci/yml/gitlab-ci.yml           | 2 ++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/ci/gitlab-ci/gitlab-ci.rst b/Documentation/ci/gitlab-ci/gitlab-ci.rst
> index 4f7ef03cca95..18360da835bd 100644
> --- a/Documentation/ci/gitlab-ci/gitlab-ci.rst
> +++ b/Documentation/ci/gitlab-ci/gitlab-ci.rst
> @@ -304,20 +304,25 @@ Description of Each Variable
>   **KCI_CHECKPATCH_OPTIONS**
>       Used in `checkpatch.pl "$KCI_CHECKPATCH_OPTIONS"` (see checkpatch
>       documentation). It is commonly used with the --ignore flag to suppress
>       specific warnings generated by checkpatch.pl. It can also be defined in the
>       commit message, since it is evaluated in run time.
>   
>   **KCI_PATCH_SERIES_SIZE**
>       Used to define the size of the patch series, see `job: checkpatch` section
>       above. It is evaluated in run time, and can be set in the commit message.
>   
> +**CI_TAGS**

I would just s/CI/KCI , I'm using KCI_prefix for those that are defined 
by us, since gitlab already uses CI_ prefix.


We will also need a way to specify tags per job at some point 
KCI_TAGS_$JOB_NAME or something, but this can be added later.

Acked-by: Helen Koike <helen.koike@collabora.com>

I'll add on top of my tree for now, so we can prepare v2 with this change.

Thanks
Helen

> +    Used to help choose which runner will deal with the current pipeline.
> +    If using Gitlab.com runners, set saas-linux-medium-amd64 or a better runner
> +    so there is enough resources to build & commit the base image.
> +
>   .. _triggering-pipelines-from-command-line:
>   
>   Triggering Pipelines from Command Line
>   --------------------------------------
>   
>   Pipelines can be triggered from the command line with custom variables using the
>   `GitLab CLI tool <https://docs.gitlab.com/ee/editor_extensions/gitlab_cli>`_.
>   
>   Example:
>   
> diff --git a/ci/gitlab-ci/yml/gitlab-ci.yml b/ci/gitlab-ci/yml/gitlab-ci.yml
> index 57b9c0290471..359b7715e3ab 100644
> --- a/ci/gitlab-ci/yml/gitlab-ci.yml
> +++ b/ci/gitlab-ci/yml/gitlab-ci.yml
> @@ -33,20 +33,22 @@ workflow:
>       - if: $FORCE_CI == 'true'
>   
>   variables:
>     FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where to look for cached images
>       # ccache builds in gitlab-runner to speed up builds
>     SMATCH_DB_DIR: /smatch/smatch_data
>     # exit code of bash script on `script` will be the exit code of the job
>     FF_USE_NEW_BASH_EVAL_STRATEGY: "true"
>   
>   default:
> +  tags:
> +    - $CI_TAGS
>     artifacts:
>       paths:
>         - artifacts/
>       when: always
>   
>   include:
>     - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/ci-fairy.yml'
>     - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/debian.yml'
>   
>     - ci/gitlab-ci/yml/kernel-combinations.yml

