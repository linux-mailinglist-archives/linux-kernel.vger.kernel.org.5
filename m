Return-Path: <linux-kernel+bounces-57064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D684D396
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F01C21FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9112882A;
	Wed,  7 Feb 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MxI+RiKJ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBE12A173
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340649; cv=none; b=D8gv5X/zwvJctSroLu3OjFZTUPIC7JLZa/ZPr/rq318DzCE7eSKXal6BGliddhGAjzfWdt3NhPf8IeE9DBOaV1dSR3T8rmdBrbHSm8VQMOPr2/8juIvdCPO9Uu2aozqwHFskCsrLaQulK3WJcR8SveZ48vSg5vYB8r3E/IyQ1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340649; c=relaxed/simple;
	bh=T6kV93mKmf951Vzyp+KxQ+jc4PnhbRAG5G4THdozP2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiAp87MDDKnb0eHDlW87ODxevpXzvMoRRHBY0W/XaRuT9+VmmVL3RPTEBepxzMySCvaWc+ddQuuC0mDFycsV4VSNVvymGiUNn3jPRSKdD7ELQqzJrwU6htWWgGfWWDQ6YnfqkCeFKPcQodNLbar+aJcYERCmP1QGVtQ0pgOsEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MxI+RiKJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b519e438so940740a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707340647; x=1707945447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYBIK21HzGnWZExBGyokNysMH1sTVDfc/C3+Eg1xvkI=;
        b=MxI+RiKJwA16FWbe/5irAiQHTp55jsnKVICfvys7vlLFSzzlR6jQWNDy/2DD283Uh7
         RQQMPcn627xG9kNfcSGQll2TumOiJ8ovBmgQmEpuX7KEbUbEp/D2mmJF7+FujTascMVM
         pRzx05MFrEd0ud1MmTAH80RgdEA0ax+9McIAOO+xqNOxvi/c1MIxbZgqObL1nekdV6oz
         HbsTZqvxqOi3RcOoTHClpMnOO+lHneo39bMRDQbipV6GjTpmbpoMhAyhN+xeWMXwY4zX
         aSG5kebQ6vFIIUIhyfjw50XNARGtxLKMMpUU3J1pwD5Uh6lUIFYUePcOv6kj+O9HKbPi
         J1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340647; x=1707945447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYBIK21HzGnWZExBGyokNysMH1sTVDfc/C3+Eg1xvkI=;
        b=cHFTdpP75DBd/QT5jWU9eVJiN36tfPf1rsEWk/iJto1OA4kdN7ARelrSr/4d8rO9Zf
         MPqJKHrxsI8uGsx7DT4xGtThPtBE13+8wogbbmy/DC3veOXpxDa1ndwPUuXXN6ZuFcvW
         ipFno0mVCUsouvTCAA9fM7Ur0UV7/rWADJDu0oQl9p+fESEJbo6BPbbDbOQQPA1O4d4Q
         MHmy6Nrjx7K+1YCmXqGx3vkPYhmdMsv/4UHmTD1XJzQ/ipz7jgLh0Bn/xRa1AeExjCjC
         cuK3xmw7zhUIzbLJM5w2ZWzqeKMLh3jGlhs8KLQAHp/zgfFpDeo7LK3mtMOyPPjpZsM8
         pn0w==
X-Forwarded-Encrypted: i=1; AJvYcCWh9F6L6H6fLe6pmy/76TEu5nhy6UmmbUvvXVV0hoGl5gMlbg+9lEw7zM92bQ7daJs9hLhtWlc5dvQKkN71Aent//R/WV2rJC9/SECg
X-Gm-Message-State: AOJu0YykxGJ80B/t8SH5YpaKiwtlMBF/L9Qk3s+eIEHguA/QsrJY7CT/
	YihCne+4FTU78Vya9rN3jk0kSFxb/ktKoh0JrBwZ/OpFm3iACQq9t2lXWz9Bg00=
X-Google-Smtp-Source: AGHT+IHoJWVVv+JqNxN0VNInjFwkpKi7xk5dOeJOeNW6H909suS/a53dIiZArzCUk+U22lRCmNHaMA==
X-Received: by 2002:a05:6a20:939e:b0:19e:6442:cdc with SMTP id x30-20020a056a20939e00b0019e64420cdcmr7333130pzh.11.1707340646965;
        Wed, 07 Feb 2024 13:17:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVA8ChgLC9erGlb8IoIg46c+AmWLsCZ6xVaXloeeeQrbGlSWOEEG2Tjgxv7Y+UgNR6P/EjzewHTcNmkfdq11SLVQ4zGaTwYMqw25+W0+/3XZfuB8VJgngE/8kwnqPu6mwts8p0Y41tplFs87tFau5SFmnW5NblBmn9PCqP4Ph2eBBA1hwQwI9fuhQYmAYF6TSyppEzAoowwA57BV3K9bR2g4aDaejD5qAhqOB5VoLjT5FJ0R6AwRrhdYB3YNczRHdVDwzsimyS9wZyI4KmiEvqH97DlW9/2EW0RVWkoT+ZLYDr4JGpjGkqJu8KVt3CNS+SeQqZqulQMd00W0TGCrUhGxJm5/nFCC9ivHg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id t22-20020a056a00139600b006e04b47e17asm2099088pfg.214.2024.02.07.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:17:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXpIK-003R8C-0T;
	Thu, 08 Feb 2024 08:17:24 +1100
Date: Thu, 8 Feb 2024 08:17:24 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	dchinner@redhat.com, djwong@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmapi_convert_delalloc
Message-ID: <ZcPzZNStEgLX+bAq@dread.disaster.area>
References: <0000000000001bebd305ee5cd30e@google.com>
 <00000000000032f84a0610c46f89@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000032f84a0610c46f89@google.com>

On Tue, Feb 06, 2024 at 10:02:05PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b0ad7be80000
> start commit:   e8c127b05766 Merge tag 'net-6.6-rc6' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
> dashboard link: https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a6f291680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116bc355680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

For real? The test doesn't even open a mounted block device for
writes...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

