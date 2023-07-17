Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A185D756263
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGQMGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGQMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:06:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289D1705
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:06:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9945315efe1so76821366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689595576; x=1692187576;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5n781+XUPoJFLyWYBhidhhIWQ79Hgbj286jbIq22wc=;
        b=iI33X4CF0zV4NUeM5mW/tiCXP9334lpxMqY2cO8f2HE9jwD1uTCYQo+ergY96HICD4
         ToHGf66JWcF9lVUZqiirRdklU7Rn8u8fYDxRYnuLFJKW/NBAZ45vmPDo7k/z+pLw+7TR
         2WUC5c/k8lrBwRdobZju4z0pUrRLHi+A8u02DaNP/ql3XtYTipKTnyLSyFikehZULdBw
         r3J4ub3fvoOS5sRsfruhxq8vU+qoovLPhpucDNoFwXEgfgPsGBqJJqXnqmNlv1gdbUwX
         GT3un9lNAvVnvt1J6mAaWnTqxLYCDl/xPID7VES9GMSbqB0leJKBdYOJWPeE7m9qMPRM
         plLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689595576; x=1692187576;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5n781+XUPoJFLyWYBhidhhIWQ79Hgbj286jbIq22wc=;
        b=Je7SCEeH9VSi1l/l+kmlZTe2VNgFUKF0N3lDDtQddlZUXF19zSRriOIPUyzsGFVBqA
         AsO/27AaVaX5wUUzgnWuY08tma0UeThqXfwnE0Fb8EMjGPesukMjDY9J4uZryyMWbFDG
         iyg95f4QncFKJGOpyic2EibxQVDVQ5j9e4Tcx/hpCUdFl8VgHXOG2SN148VYXwqlezzM
         LB+I0gj1uvx8JDHmnhLjzXMqB6g/Du4q1u3nhiSPE1yq+InZaqVoPM46xHoNy8X1gD3m
         03krKZJFfAluMnp7FQnVTByVUocUoSFfAI9KnRv+LNOCuuhzPVEBzP2b2csN+Vs/Svrw
         hoAg==
X-Gm-Message-State: ABy/qLZiHxwk72lPDjUTGHy8Dj/HdlMgi7SXlte2WvAhbT8iBlck1FuK
        ZUBxv2K13wT6AmckjuoANx6FTN2CE+2gYofRAlI=
X-Google-Smtp-Source: APBJJlEIlzCG3PeNH60VFSoIU6A88rF2IZkc7NregtPJ0dDEuRTkgtlzxrRWiINa/Y1HsnRw7trqQWbtPy1AMPnfm80=
X-Received: by 2002:a05:6402:524b:b0:51d:9a92:24f0 with SMTP id
 t11-20020a056402524b00b0051d9a9224f0mr7275401edd.4.1689595576358; Mon, 17 Jul
 2023 05:06:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:c48b:0:b0:51d:f36d:2cee with HTTP; Mon, 17 Jul 2023
 05:06:15 -0700 (PDT)
Reply-To: mrs.isabella.g.lawson@gmail.com
In-Reply-To: <CAJTZSF9cSny--QurC_8=H98RXaFaYPBrbJG5KbaF5pXX3ykH+A@mail.gmail.com>
References: <CAJTZSF9cSny--QurC_8=H98RXaFaYPBrbJG5KbaF5pXX3ykH+A@mail.gmail.com>
From:   "Mrs.Isabelle" <akimouzoumaro94@gmail.com>
Date:   Mon, 17 Jul 2023 12:06:15 +0000
Message-ID: <CAJTZSF_ttQTKWWwv6+E27d9HV-Ge5+fpa=wk4gw5jdK+9YbFuA@mail.gmail.com>
Subject: I have a project I want you to handle, kindly get back to me for more
 details about me and the project. Sincerely, Mrs Isabelle Phone/whatsapp...
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q1
