Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51B7F9B04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjK0Hby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0Hbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:31:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DD12D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:31:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053BC433C7;
        Mon, 27 Nov 2023 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701070319;
        bh=yLp1JcuOdJe5gHRSub4HJF4UrVwP6kHxoOFHEWvht7A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ngDGGge4mQxQ+e9BShADqKEIoAk5rbVaS5M3WjNvUoJe2G8vN6yvZ2fQbzdXk53rZ
         XaSa0ZCvRwtFN+qO+9dA+3ZOB2ZO4T9gM3FQZnLysQ/4s/RTQSkZLgwjJ+VS92xf2s
         fNExaV80kIrMBKxuZzi1KVC1lBR3Z4UOyZf3BpuA08DO4obcoLy44090v/0vVc5pLg
         usZZbb2nUedOoQRCBKSEzRJldn9dQCKZsNyTzI6A15ywIDHd+f1qeVXJgyZdXZF7aK
         jwV3WvFdva9EwMFqDTmBK6SIGzwMrFqWnUoUVefZUM7zi8qCg6mx21+OGUlNYJQxcv
         E/AtgTSAa9iGg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
        <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
Date:   Mon, 27 Nov 2023 09:31:55 +0200
In-Reply-To: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Fri, 24 Nov 2023 11:09:18
 +0200")
Message-ID: <87a5qz7itw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Replace literal 0x7f with PCI_HEADER_TYPE_MASK.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

I couldn't find the cover letter. Should I take this patch to
wireless-next or do you have other plans for this?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
