Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED17E9BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjKMMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:07:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2682D73;
        Mon, 13 Nov 2023 04:07:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EDFC433C7;
        Mon, 13 Nov 2023 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699877266;
        bh=4wlY34yA/NZoVOF4oQbm/htpzM60UGkfAML7KHwXaGU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gO/lyOKd01bzEtI6LD3gxYSWc6gN8ceTyt2G2v9lWamYWLFm/8xlAtK6FZCm8kxVk
         7i+CY5CRGp2lnuLTvsan4I1ezH1x3CFqs2PJGelbiADnfpqmqEyb7PkdOEFiOtQR4K
         iC07cLNRDQOibB/tN2rNSkQ5mAwSMdgvzH/8oeOXA68umYmziLnbYMK4byAKzHD8/v
         0k6UvB7ltHjkl71ATPPl2bldlDlsE6PryiM4P0yzKmFVhJtnmrFMivZWVpFejNYlQ6
         Qy4HORXFDTpxSXBTSzOejmD5n5K/UVWqLNu2k0H4HJyEBQhU+9Fgi0BI5BCbo9zc47
         qDhpN3l1djhfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless-next] wlcore: debugfs: add an error code check
 in beacon_filtering_write
References: <065d6090-38fc-0cc0-db47-f9ba5b1c5d7d@nfschina.com>
Date:   Mon, 13 Nov 2023 14:07:43 +0200
In-Reply-To: <065d6090-38fc-0cc0-db47-f9ba5b1c5d7d@nfschina.com> (Su Hui's
        message of "Mon, 13 Nov 2023 14:53:28 +0800")
Message-ID: <878r71vots.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su Hui <suhui@nfschina.com> writes:

> On 2023/11/13 14:16, Kalle Valo wrote:
>
>> Su Hui <suhui@nfschina.com> writes:
>>
>>> wl1271_acx_beacon_filter_opt() return error code if failed, add a check
>>> for this is better and safer.
>>>
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> How did you test this?
>
> Only compile test.

If you have only compile tested please document that clearly in the
commit message.

> Clang static checker complains about this code that=C2=A0 value stored to
> 'ret' is never read.

This would be good to also have in the commit message.

> And most of the caller check=C2=A0 the error code of
> wl1271_acx_beacon_filter_opt().

This might still break something so I would prefer to test this in a
real device before taking it.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
