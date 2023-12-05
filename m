Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E098043CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjLEBMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjLEBMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:12:42 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9EDC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:12:48 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35d4e557c4bso17749135ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 17:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701738768; x=1702343568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L33oYQvZ1X9QshoXk8uWXk0doNVm+LX5qzUYAgX80+o=;
        b=VU7SuEsn4+VkVio2vG2VdHWoUeezNXSnAtmjZ+DhEFzBhQoa1J4yjkJzeqnrq8d3CL
         vytzg8aY41oWxrE0CJHwYdl0ycxun/khxo6pzrn1Z6XdynjHeunN2AiVjVyzkWxJN/7o
         /YxKCiAZfk5z1FgxlX5iBwGTpY2tZvI38VqnV8+xLmIFY5TKkpTExukfG7r/NABA/2d9
         P84TekeOarKeDlotlxRY7DHBpDh7zP+dF9aW0rbrgQEZlAwk8yBR5CATYT9fxRXCikug
         FVW/DhDVCrRKd1nu1EFUAz03S2p3waZWaBZtPAWbXmplre0vgQZMy6oholY8mUfLOkDq
         0APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701738768; x=1702343568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L33oYQvZ1X9QshoXk8uWXk0doNVm+LX5qzUYAgX80+o=;
        b=CfrAQt6zKh0OC8WRt8SZ2MgTobr8SvkgzMbFyyaeRKddr/LGcw3idCbIGrOOGz+UFr
         Dqjdmkf4B3MfaZ9UVLtovThJgWP8WjrVeyATj39Bq1hX6I6rBCgNFtMZB0NpF586IeN7
         W/hkKOSF2f7BjdwKEf9DlxKighvdDyrv6c9NnyJ3mjjYe5Z19jun7jmXOK179D2EYuk6
         OAjZgi5iaKzlNm7NePU84toc8lZOglWWZiMartWYlS2Zz+emSlGQWF25bt3WV7C8tJ0m
         nvIPPrlBJvetRQOXtonyV6ip7zOyp+sHBKlGrgrheyEbRLv4Dl8jkAr8HNzOTcQpbmjK
         0b9g==
X-Gm-Message-State: AOJu0YxAs3tzqS9uJhwtvs7CGsJXgXC6RabTXpu8EysYtPVi9xbB16Mw
        ak+GRKSv16Z074j1joNxBVHMSw==
X-Google-Smtp-Source: AGHT+IEWJJxT8tQmCfczDL0XVMjNGvUCiSkuiaKlY/6nj9Yxw3SO/DeWl9qMxiysLZAVGyLd9Kv5Gw==
X-Received: by 2002:a92:4a0d:0:b0:35d:63b2:48c4 with SMTP id m13-20020a924a0d000000b0035d63b248c4mr4733150ilf.65.1701738767991;
        Mon, 04 Dec 2023 17:12:47 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id s7-20020a634507000000b005bcebc93d7asm8199060pga.47.2023.12.04.17.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 17:12:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rAJzR-003y4I-03;
        Tue, 05 Dec 2023 12:12:45 +1100
Date:   Tue, 5 Dec 2023 12:12:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Kunhai Dai <daikunhai@didiglobal.com>
Cc:     chandan.babu@oracle.com, djwong@kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: adjust the offset of the log statistics line
Message-ID: <ZW55DaL4mF9vO91L@dread.disaster.area>
References: <20231204072644.1012309-1-daikunhai@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204072644.1012309-1-daikunhai@didiglobal.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 02:26:44AM -0500, Kunhai Dai wrote:
> It would be more preferable to present xs_try_logspace and
> xs_sleep_logspace on the log line.

xs_try_logspace and xs_sleep_logspace are AIL tail pushing
statistics. They are related to reservation space exhaustion, not
journal operations, so they really are located in the correct stats
namespace. 

Regardless of whether they are correctly located, we can't change
the layout of this file like this - it forms part of the user kABI.
The file format was defined back in June 2000 (early stages of the
XFS port to Linux) and so any change to the layout of the file will
break every application and script every written that parses it.

So while it might be "preferable" to change the order of stats in
the file to group them better, we simply cannot do that because it
will break userspace.

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com
