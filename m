Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39167A0CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbjINSfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjINSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:35:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6311FE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:35:10 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58c92a2c52dso14310117b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694716509; x=1695321309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4Q3FdiJ3V5TocPUmywGK8xhOPCwVplUhl/7cc56tKs=;
        b=kjALx/etTmLiSyiLT31097blLcerEyRDJsb0feaKDDDoUJdqYz0zLiBYZEwnQ8sPP8
         3XlCrzX9zy1hJxMxJ5U0fmuof8VoWDADBzC3sNWLFqj6aLT3YBA+TWV4e85cXkqIXkrP
         7Z25HmN4BO4cjTEMOd1oSC03ohP8DeTUp23T4/f+N2YqurA6kWBvYSJ0WuE8Ncg4rTyE
         mNsu0cFIosfsJ3Ll6TgKL8fRJ8HXHs3tzTMPIuq9AcUvsmo3WDDouD/HIzeKPy9aB0nv
         8pH2tVNrxqnoFnbGyRKexkZs5/dLZlg+9vcv5WuyqnJzrfZwgRd+6l/WeiF3UIkha+3H
         mn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716509; x=1695321309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4Q3FdiJ3V5TocPUmywGK8xhOPCwVplUhl/7cc56tKs=;
        b=fCsEVBu6ZXKzI9K6FWTzoUBIywg+umkLhmKgGUHyIo/tVdRRTDke5Jw1XGXN6EFaMa
         k5LfV2PoKWV6afPnwmh42/j2tjj1DgHiWcxhtYLk6dpwxMgxzMqxBmgg8BMKazH8nIne
         WQYqwAlZmup2k+rH9pXvB+fNHs+/DkoGHKR3RJ5ciT9fV3jZR93FdUVqVIIxxz0ZqI9k
         YvNXN/KKKjsegfVNm9n9S/Ja/dY2T1FqBCpzG7jOeuOi++WA4dnHo2npnLfiK4yU/bFU
         5s0V/szlqQvkVh/XRaZUa4NnKaQqr+f4Dt4OifpQwLIrAlXtrdrBZkNuUVkQ5OLvDc68
         1fSA==
X-Gm-Message-State: AOJu0YzcLZPrkgiIvwwuU35X2IULAL0m5nYUtERt0ZmpXqQBRLN+iY0T
        lHwgF+cgMh+31XUQgo8DOw7bYmtUWb7tTwpm+OKVrQ==
X-Google-Smtp-Source: AGHT+IE9ZnOpWrcwxwpcgRXYoq7Lu7MkOeyawrED+id/g0j10DlEQ3H2jkxDCgAOPvVd5t4gWKjWUV4ooJs+LIiPMy8=
X-Received: by 2002:a25:cc12:0:b0:d81:9612:46fe with SMTP id
 l18-20020a25cc12000000b00d81961246femr2646408ybf.57.1694716507971; Thu, 14
 Sep 2023 11:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-2-surenb@google.com>
 <ZQNJU67eDoZqffEQ@casper.infradead.org>
In-Reply-To: <ZQNJU67eDoZqffEQ@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 11:34:54 -0700
Message-ID: <CAJuCfpGEVhag8zsC1zA0acZna9vRhe9vnWHWW+ozE42atv9OOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:56=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Sep 14, 2023 at 08:26:11AM -0700, Suren Baghdasaryan wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > As far as the rmap code is concerned, UFFDIO_REMAP only alters the
> > page->mapping and page->index. It does it while holding the page
>
> folio->mapping and folio->index.  It does it while holding the folio

Ack.

>
> No other objections ...

Thanks for the review!
