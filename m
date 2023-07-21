Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09475C054
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGUHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:47:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83D9359C;
        Fri, 21 Jul 2023 00:46:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso14673895e9.1;
        Fri, 21 Jul 2023 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689925580; x=1690530380;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ0t8tKCY40a32zHbfbDa1TpUg7wE+dfip+LGmkLnbA=;
        b=mdPmT6BZdkaQy+/LaareGweR1SBId4RNzXRFrcfEnI7XZOPU+/I1kowzrII1DSGQs3
         nblCC/vwzNFG/vRXMzWO+3a8bIFPcmenUlVmfMs8GMF6xTVZsdQoZQzrEuzkR9FqevVk
         VqBH6UgptflpQmaZNl7DN4rfX4NDECUBBMDexh6o4zj62aQp50vu2U3SvgDLrTktMlHk
         0oI46aqKGWKm+hLcJ8wBSv0/oXUoNnnza+kQ8zgYVtRvwLLQtwjxPdWEnTrDzO8raDbW
         aMHH0u/VbS8Z43zMzSSobcnyKH+4mqd3np+SqcUfnDNT3eHTdTL3lX+Gus6THbnPVKTx
         d4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925580; x=1690530380;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ0t8tKCY40a32zHbfbDa1TpUg7wE+dfip+LGmkLnbA=;
        b=k1PpF+XX0UV6VdZSF07TvX+7Tw4niEGZbfhRVpAWZ9VX5G33ItRQWfhep66xuKzaw7
         ODXhzKSp7y/03+h1TKtK3XkLbolrZtZzDbg6p9AQ2cFsWhdKLFN4Blj9oEqFMufvYwj/
         M6grYYURsW4nOLMXjnd8wjBj0+QjplJkmsHkrkbLSSoi+oLz/qDaahGNgwLKeeqkVGDj
         lLUuEoEpZ/PE8k+6HjiJNxOC8cMCaXGGroowyUAo5tKTqCvOUnJTHPxs69tbBnWlYL3Q
         Q48TKy6rjNyMgjGidiGJVkqQzTdvxaBhiHHnXF5k1+YH8y3i6E56HNInJCdBU/TUNneL
         AFLA==
X-Gm-Message-State: ABy/qLYixc21QXiF3db0aq//x4TTPQLgvc7ZNWLk/4r7IiwfVk7nLH0z
        S7rbL9PKrm7PuCw5k1C132A=
X-Google-Smtp-Source: APBJJlH77Wp95qPDMbHLmHjtVlZbRmHw4naW1VDuJs9u4M3+PTHGN5a2K0SWksJS5cZ9Z8n+QyBphQ==
X-Received: by 2002:a7b:c405:0:b0:3fa:97ad:2b9f with SMTP id k5-20020a7bc405000000b003fa97ad2b9fmr876126wmi.16.1689925579913;
        Fri, 21 Jul 2023 00:46:19 -0700 (PDT)
Received: from gmail.com ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c204300b003fc3b03e41esm5881060wmg.1.2023.07.21.00.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:46:19 -0700 (PDT)
Date:   Fri, 21 Jul 2023 08:46:16 +0100
From:   Martin Habets <habetsm.xilinx@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <ZLo3yDUue5b6kD8P@gmail.com>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net,
        Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
References: <20230719183225.1827100-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719183225.1827100-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:32:25AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks good. Thanks!
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
> v3:
>  - clarify that mailings list in addition to humans is fine (Mark)
>  - reword the "review from one maintainer is enough" (Benjamin)
>  - grammar fixes (Benjamin, Shannon)
>  - typos (Andrew, Shannon)
> v2: https://lore.kernel.org/all/20230718155814.1674087-1-kuba@kernel.org/
>  - use Thorsten's wording for bug fixing requirements
>  - put more words into the review/response timeline expectations
> v1: https://lore.kernel.org/all/20230713223432.1501133-1-kuba@kernel.org/
> 
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux@leemhuis.info
> Cc: kvalo@kernel.org
> Cc: benjamin.poirier@gmail.com
> ---
>  .../feature-and-driver-maintainers.rst        | 155 ++++++++++++++++++
>  Documentation/maintainer/index.rst            |   1 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst
> 
> diff --git a/Documentation/maintainer/feature-and-driver-maintainers.rst b/Documentation/maintainer/feature-and-driver-maintainers.rst
> new file mode 100644
> index 000000000000..f04cc183e1de
> --- /dev/null
> +++ b/Documentation/maintainer/feature-and-driver-maintainers.rst
> @@ -0,0 +1,155 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Feature and driver maintainers
> +==============================
> +
> +The term "maintainer" spans a very wide range of levels of engagement
> +from people handling patches and pull requests as almost a full time job
> +to people responsible for a small feature or a driver.
> +
> +Unlike most of the chapter, this section is meant for the latter (more
> +populous) group. It provides tips and describes the expectations and
> +responsibilities of maintainers of a small(ish) section of the code.
> +
> +Drivers and alike most often do not have their own mailing lists and
> +git trees but instead send and review patches on the list of a larger
> +subsystem.
> +
> +Responsibilities
> +================
> +
> +The amount of maintenance work is usually proportional to the size
> +and popularity of the code base. Small features and drivers should
> +require relatively small amount of care and feeding. Nonetheless
> +when the work does arrive (in form of patches which need review,
> +user bug reports etc.) it has to be acted upon promptly.
> +Even when a particular driver only sees one patch a month, or a quarter,
> +a subsystem could well have a hundred such drivers. Subsystem
> +maintainers cannot afford to wait a long time to hear from reviewers.
> +
> +The exact expectations on the response time will vary by subsystem.
> +The patch review SLA the subsystem had set for itself can sometimes
> +be found in the subsystem documentation. Failing that as a rule of thumb
> +reviewers should try to respond quicker than what is the usual patch
> +review delay of the subsystem maintainer. The resulting expectations
> +may range from two working days for fast-paced subsystems (e.g. networking)
> +to as long as a few weeks in slower moving parts of the kernel.
> +
> +Mailing list participation
> +--------------------------
> +
> +Linux kernel uses mailing lists as the primary form of communication.
> +Maintainers must be subscribed and follow the appropriate subsystem-wide
> +mailing list. Either by subscribing to the whole list or using more
> +modern, selective setup like
> +`lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
> +
> +Maintainers must know how to communicate on the list (plain text, no invasive
> +legal footers, no top posting, etc.)
> +
> +Reviews
> +-------
> +
> +Maintainers must review *all* patches touching exclusively their drivers,
> +no matter how trivial. If the patch is a tree wide change and modifies
> +multiple drivers - whether to provide a review is left to the maintainer.
> +
> +When there are multiple maintainers for a piece of code an ``Acked-by``
> +or ``Reviewed-by`` tag (or review comments) from a single maintainer is
> +enough to satisfy this requirement.
> +
> +If the review process or validation for a particular change will take longer
> +than the expected review timeline for the subsystem, maintainer should
> +reply to the submission indicating that the work is being done, and when
> +to expect full results.
> +
> +Refactoring and core changes
> +----------------------------
> +
> +Occasionally core code needs to be changed to improve the maintainability
> +of the kernel as a whole. Maintainers are expected to be present and
> +help guide and test changes to their code to fit the new infrastructure.
> +
> +Bug reports
> +-----------
> +
> +Maintainers must ensure severe problems in their code reported to them
> +are resolved in a timely manner: regressions, kernel crashes, kernel warnings,
> +compilation errors, lockups, data loss, and other bugs of similar scope.
> +
> +Maintainers furthermore should respond to reports about other kinds of
> +bugs as well, if the report is of reasonable quality or indicates a
> +problem that might be severe -- especially if they have *Supported*
> +status of the codebase in the MAINTAINERS file.
> +
> +Selecting the maintainer
> +========================
> +
> +The previous section described the expectations of the maintainer,
> +this section provides guidance on selecting one and describes common
> +misconceptions.
> +
> +The author
> +----------
> +
> +Most natural and common choice of a maintainer is the author of the code.
> +The author is intimately familiar with the code, so it is the best person
> +to take care of it on an ongoing basis.
> +
> +That said, being a maintainer is an active role. The MAINTAINERS file
> +is not a list of credits (in fact a separate CREDITS file exists),
> +it is a list of those who will actively help with the code.
> +If the author does not have the time, interest or ability to maintain
> +the code, a different maintainer must be selected.
> +
> +Multiple maintainers
> +--------------------
> +
> +Modern best practices dictate that there should be at least two maintainers
> +for any piece of code, no matter how trivial. It spreads the burden, helps
> +people take vacations and prevents burnout, trains new members of
> +the community etc. etc. Even when there is clearly one perfect candidate,
> +another maintainer should be found.
> +
> +Maintainers must be human, therefore, it is not acceptable to add a mailing
> +list or a group email as a maintainer. Trust and understanding are the
> +foundation of kernel maintenance and one cannot build trust with a mailing
> +list. Having a mailing list *in addition* to humans is perfectly fine.
> +
> +Corporate structures
> +--------------------
> +
> +To an outsider the Linux kernel may resemble a hierarchical organization
> +with Linus as the CEO. While the code flows in a hierarchical fashion,
> +the corporate template does not apply here. Linux is an anarchy held
> +together by (rarely expressed) mutual respect, trust and convenience.
> +
> +All that is to say that managers almost never make good maintainers.
> +The maintainer position more closely matches an on-call rotation
> +than a position of power.
> +
> +The following characteristics of a person selected as a maintainer
> +are clear red flags:
> +
> + - unknown to the community, never sent an email to the list before
> + - did not author any of the code
> + - (when development is contracted) works for a company which paid
> +   for the development rather than the company which did the work
> +
> +Non compliance
> +==============
> +
> +Subsystem maintainers may remove inactive maintainers from the MAINTAINERS
> +file. If the maintainer was a significant author or played an important
> +role in the development of the code, they should be moved to the CREDITS file.
> +
> +Removing an inactive maintainer should not be seen as a punitive action.
> +Having an inactive maintainer has a real cost as all developers have
> +to remember to include the maintainers in discussions and subsystem
> +maintainers spend brain power figuring out how to solicit feedback.
> +
> +Subsystem maintainers may remove code for lacking maintenance.
> +
> +Subsystem maintainers may refuse accepting code from companies
> +which repeatedly neglected their maintainership duties.
> diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
> index 3e03283c144e..eeee27f8b18c 100644
> --- a/Documentation/maintainer/index.rst
> +++ b/Documentation/maintainer/index.rst
> @@ -9,6 +9,7 @@ additions to this manual.
>  .. toctree::
>     :maxdepth: 2
>  
> +   feature-and-driver-maintainers
>     configure-git
>     rebasing-and-merging
>     pull-requests
> -- 
> 2.41.0
> 
