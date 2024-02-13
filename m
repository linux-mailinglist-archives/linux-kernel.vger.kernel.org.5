Return-Path: <linux-kernel+bounces-64199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B6853BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7951C2688D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25E608ED;
	Tue, 13 Feb 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dSg5oiHi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E760890;
	Tue, 13 Feb 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854206; cv=none; b=FAYVuJ/58a+nc6tsDSZ9wXUD1sR1uR0jzviL8MhXkq5CW8RXT9tjchlsFdjWwl3TWx6NT36EFX19yoMm6lMS4OXq053gF/qZB9kulz54kRX1dLv2GlwzOX2SKUEBpGQTbl0EDln2Qs8xdbWTE/KqKm1OY0h7f4InvqiECZPni7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854206; c=relaxed/simple;
	bh=W6SmpzS6kL9BOCJyo7tCc7YBuIesMM/4UogZi33YWjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f55AwTN1YrJu3hio1KzSZr6YoNeyfncHQjhV7xTP5AuTozy7Ne5xogIQuvDDLjUYWkgn8jFgwOOU+AIzP2kxch1wYwq1kIY+fouE55gmPQk4Z6lMbkv6TfA3LYdOaBPuMqKFy1sK7ynV3bVgk8iD1UEUyuAkdyLUdc7czDJEPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dSg5oiHi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=o+K0mlcOJMNUUPLD8g9New5Bn+aZBxAJd+BG2+LIh3I=; b=dSg5oiHisxGZ8zwsJIk6CNA8xu
	zrgW8+qMzxafbpTxaMQ1WzHXfQU8aDblH6gMWgn/eAOYPomH9RvMJs8QYX1Uux1T/cRJ7LmsBrmGR
	l9Ym2ejqIFrhJT5mG7A+lpX3I8uj0/s0q4L+Yxs/Mdk/grbwP/hYnJ6vbA7ElXAFSVlZl7NRDUetH
	+XsioHtW+cvG+dyv7RHxYxFhpO135myjDyyR2vkjsHtjlMvFqDxHfcIx/EogziUYF7fc9Tv6y+BNF
	XiG4rML+3+MvckMJk08qlxybM7UrVPvkcZpjRJ1DIa5b/0fdUB69s0DjAuxdLprhtQQHy1AaKzJR8
	Ot5QhfsA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZytW-0000000AXq5-2wuk;
	Tue, 13 Feb 2024 19:56:42 +0000
Message-ID: <60d67476-5c56-4fa4-93cf-1eb8f5aa5953@infradead.org>
Date: Tue, 13 Feb 2024 11:56:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org,
 Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
References: <2024021314-unwelcome-shrill-690e@gregkh>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2024021314-unwelcome-shrill-690e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/24 10:48, Greg Kroah-Hartman wrote:
> The Linux kernel project now has the ability to assign CVEs to fixed
> issues, so document the process and how individual developers can get a
> CVE if one is not automatically assigned for their fixes.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  Documentation/process/cve.rst           | 116 ++++++++++++++++++++++++
>  Documentation/process/index.rst         |   1 +
>  Documentation/process/security-bugs.rst |   6 +-
>  3 files changed, 120 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/process/cve.rst
> 
> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> new file mode 100644
> index 000000000000..17df5d673102
> --- /dev/null
> +++ b/Documentation/process/cve.rst
> @@ -0,0 +1,116 @@
> +CVEs
> +====
> +
> +Common Vulnerabilities and Exposure (CVE®) numbers, were developed as an

                            no comma                 ^

> +unambiguous way to identify, define, and catalog publically disclosed

                                                    publicly

> +security vulnerabilities.  Over time, their usefulness has declined with
> +regards to the kernel project, and CVE numbers were very often assigned
> +in inappropriate ways and for inappropriate reasons.  Because of this,
> +the kernel development community has tended to avoid them.  However, the
> +combination of continuing pressure to assign CVEs and other forms of
> +security identifiers, and ongoing abuses by community members outside of
> +the kernel community has made it clear that the kernel community should
> +have control over those assignments.
> +
> +The Linux kernel developer team does have the ability to assign CVEs for
> +potential Linux kernel security issues.  This assignment is independent
> +of the :doc:`normal Linux kernel security bug reporting
> +process<../process/security_bugs>`.
> +
> +A list of all assigned CVEs for the Linux kernel can be found in the
> +archives of the linux-cve mailing list, as seen on
> +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> +assigned CVEs, please subscribe to that mailing list.
> +
> +Process
> +-------
> +
> +As part of the normal stable release process, kernel changes that are
> +potentially security issues are identified by the developers responsible
> +for CVE number assignments and have CVE numbers automatically assigned
> +to them.  These assignments are published on the linux-cve mailing list

                                                    linux-cve-announce mailing list

> +as announcements on a frequent basis.
> +
> +Note, due to the layer at which the Linux kernel is in a system, almost
> +any bug might be exploitable to compromise the security of the kernel,
> +but the possibility of exploitation is often not evident when the bug is
> +fixed.  Because of this, the CVE assignment team are overly cautious and

                                                    is
to be consistent.

> +assign CVE numbers to any bugfix that they identify.  This
> +explains the seemingly large number of CVEs that are issued by the Linux
> +kernel team.
> +
> +If the CVE assignment team misses a specific fix that any user feels
> +should have a CVE assigned to it, please email them at <cve@kernel.org>
> +and the team there will work with you on it.  Note, that no potential

                             no comma                ^

> +security issues should be sent to this alias, it is ONLY for assignment
> +of CVEs for fixes that are already in released kernel trees.  If you
> +feel you have found an unfixed security issue, please follow the
> +:doc:`normal Linux kernel security bug reporting
> +process<../process/security_bugs>`.
> +
> +No CVEs will be assigned for unfixed security issues in the Linux
> +kernel, assignment will only happen after a fix is available as it can

   kernel;

> +be properly tracked that way by the git commit id of the original fix.
> +
> +No CVEs will be assigned for any issue found in a version of the kernel
> +that is not currently being actively supported by the Stable/LTS kernel
> +team.  A list of the currently supported kernel branches can be found at
> +https://kernel.org/category/releases.html
> +
> +Disputes of assigned CVEs
> +-------------------------
> +
> +The authority to dispute or modify an assigned CVE for a specific kernel
> +change lies solely with the maintainers of the relevant subsystem
> +affected.  This principle ensures a high degree of accuracy and
> +accountability in vulnerability reporting.  Only those individuals with
> +deep expertise and intimate knowledge of the subsystem can effectively
> +assess the validity and scope of a reported vulnerability and determine
> +its appropriate CVE designation.  Any attempt to modify or dispute a CVE
> +outside of this designated authority could lead to confusion, inaccurate
> +reporting, and ultimately, compromised systems.
> +
> +Invalid CVEs
> +------------
> +
> +If a security issue is found in a Linux kernel that is only supported by
> +a Linux distribution due to the changes that have been made by that
> +distribution, or due to the distribution supporting a kernel version
> +that is no longer one of the kernel.org supported releases, then a CVE
> +can not be assigned by the Linux kernel CVE team, and must be asked for
> +from that Linux distribution itself.
> +
> +Any CVE that is assigned against the Linux kernel for an actively
> +supported kernel version, by any group other than the kernel assignment
> +CVE team should not be treated as a valid CVE.  Please notify the
> +kernel CVE assignment team at <cve@kernel.org> so that they can work to
> +invalidate such entries through the CNA remediation process.
> +
> +Applicability of specific CVEs
> +------------------------------
> +
> +As the Linux kernel can be used in many different ways, with many
> +different ways of accessing it by external users, or no access at all,
> +the applicability of any specific CVE is up to the user of Linux to
> +determine, it is not up to the CVE assignment team.  Please do not
> +contact us to attempt to determine the applicability of any specific
> +CVE.
> +
> +Also, as the source tree is so large, and any one system only uses a
> +small subset of the source tree, any users of Linux should be aware that
> +large numbers of assigned CVEs are not relevant for their systems.
> +
> +In short, we do not know your use case, and we do not know what portions
> +of the kernel that you use, so there is no way for us to determine if a
> +specific CVE is relevant for your system.
> +
> +As always, it is best to take all released kernel changes, as they are
> +tested together in a unified whole by many community members, and not as
> +individual cherry-picked changes.  Also note that for many bugs, the
> +solution to the overall problem is not found in a single change, but by
> +the sum of many fixes on top of each other.  Ideally CVEs will be
> +assigned to all fixes for all issues, but sometimes we do not notice
> +fixes in released kernels, so do not assume that because a specific
> +change does not have a CVE assigned to it, that it is not relevant to
> +take.
> +


-- 
#Randy

