Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C747E496F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjKGTyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:54:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC61D7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:54:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so10318996a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699386860; x=1699991660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VkTZWMBMLQYUtpSNuy5XagVZn8+B9GVBKFpPpKcdRS4=;
        b=eqc87QZVPahJ5XT4X/bPlLV4zUJeLeRzl6J2dEbou1ea6AHFYWBsbxxH1CDhUZ6o8i
         Wd5Ey7OgDOMl/bMQUaopkNI21jLpry+ynf3KydynFdrYMMnbp7fYm3Hvf3ASkRsY1MdW
         oJAcM9yQxI6kTCKCyA71oelrHy7qOPivLu6Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386860; x=1699991660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkTZWMBMLQYUtpSNuy5XagVZn8+B9GVBKFpPpKcdRS4=;
        b=OcqXIA65ozGiwZ0tWNvD9pHyXJLXKXBJUiJ5MJeSq/eePoPBeR37lp6wnyt2Ap/0zz
         z7wDUSkSUEX0pu8TmhtjDhfgxJNw2PY2sgJqtYUe1I5J29lQhAhL6cejIWO1DWwzal9D
         JHHYjcr6pvqie7B8i11zHDIzQqkr2kl22Y6odBzIXydPE4G7culUr7KVHc5b25WFpVc6
         a/1L9dwdwZ10RYoVGGxQZa2AF6a10qnGSWihTnP513TrPAzivYpJ4aq3QmERsccIrR5R
         0jK2vwbS1hnYsD8mzBcN33LXhSaiF1KOJRLSoL5bbtiqOSjg3C9NVpalfqV3LERgebWs
         J1qQ==
X-Gm-Message-State: AOJu0YxLc66quTSLlZOPFCS1e0d+gT6hQJN7sHBjnAx1/CTBi3pTUMq4
        bSWD5skT6r6NYDiH71i8IPa1KspfWPKbzsaB+Eg=
X-Google-Smtp-Source: AGHT+IFYFM3wHMMPn4TjmEjH5mv+8TqpWbBQ8A0JjLuRoVcChR7FJK/Mk+URr1uUX0VaXT9Ah/sA5Q==
X-Received: by 2002:a50:baae:0:b0:542:d2c4:b423 with SMTP id x43-20020a50baae000000b00542d2c4b423mr22068289ede.30.1699386860526;
        Tue, 07 Nov 2023 11:54:20 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id f29-20020a50a6dd000000b0053dff5568acsm5872438edc.58.2023.11.07.11.54.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 11:54:19 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9e213f198dfso206353366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:54:19 -0800 (PST)
X-Received: by 2002:a17:907:745:b0:9dd:4811:7111 with SMTP id
 xc5-20020a170907074500b009dd48117111mr13172773ejb.4.1699386858967; Tue, 07
 Nov 2023 11:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20231106065045.895874-1-amir73il@gmail.com>
In-Reply-To: <20231106065045.895874-1-amir73il@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Nov 2023 11:54:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgCwcUGKvoZX0OSAFi9fTye3BOfOCY+wR=t7W8xS_oGQ@mail.gmail.com>
Message-ID: <CAHk-=whgCwcUGKvoZX0OSAFi9fTye3BOfOCY+wR=t7W8xS_oGQ@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.7
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2023 at 22:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> - Overlayfs aio cleanups and fixes [1]
>
> - Overlayfs lock ordering changes [2]
>
> - Add support for nesting overlayfs private xattrs [3]
>
> - Add new mount options for appending lowerdirs [4]
>
> [1] https://lore.kernel.org/r/20230912173653.3317828-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/r/20230816152334.924960-1-amir73il@gmail.com/
> [3] https://lore.kernel.org/r/cover.1694512044.git.alexl@redhat.com/
> [4] https://lore.kernel.org/r/20231030120419.478228-1-amir73il@gmail.com/

*Please* don't make me have to follow links just to see basic details.

Merge messages should stand on their own, not just point to "look,
here are the details in our lore archives". Yes, even when having
internet access is much more common, there are situations where it's
not there or is slow. Or maybe lore has issues. Or maybe people just
don't want to switch to a browser to look up details that may or may
not be relevant to them.

I copied the relevant stuff into my merge, but please don't make me do
this next time. Just give me a merge message with the details spelled
out, not some link to a cover letter for a patch series.

             Linus
