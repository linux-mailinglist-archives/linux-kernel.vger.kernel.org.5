Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7344678E70B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbjHaHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbjHaHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:15:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A49E59;
        Thu, 31 Aug 2023 00:14:59 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7F3DC212A771;
        Thu, 31 Aug 2023 00:14:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F3DC212A771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693466098;
        bh=2z5gw3ytBuygGDs1dY8jzo0OCP4TrdhZNJj6EowZE3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZm1eK9g/CO1f+Nj64/Mb8FxIWAcYIY/W/zXKZq6EucXXKe5qic90Uv9ycz1sE4Et
         R6aMtCLmOek4H1r+d1vcgqhwKU0b3EIDErNJ36O2fz6FRs77FCVKz2mqJjNDBlK7lb
         WoDDl6LaKl1M4VUSD0tYezTlaWRqQAWzYm44pi9c=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Thu, 31 Aug 2023 09:14:55 +0200
Message-ID: <2696412.mvXUDI8C0e@pwmachine>
In-Reply-To: <20230829195719.0eaf9035@rorschach.local.home>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com> <20230825221321.faaa33e03afc48abc345c24f@kernel.org> <20230829195719.0eaf9035@rorschach.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le mercredi 30 ao=FBt 2023, 01:57:19 CEST Steven Rostedt a =E9crit :
> On Fri, 25 Aug 2023 22:13:21 +0900
>=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > Excellent catch! Thank you, I will apply this patch and send v4 right
> > > after. Regarding test, do you think I can add a test for the
> > > EADDRNOTAVAIL case?>=20
> > Hmm, in that case, you need to change something in tracefs/README so th=
at
> > we can identify the kernel has different behavior. Or we have to change
> > this is a "Fix" for backporting.
>=20
> I prefer this to be a Fix and backported.

This makes sense, I will send v5 to stable mailing list too!
=20
> Thanks,
>=20
> -- Steve

Best regards.


