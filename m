Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82079D83A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjILSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjILSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:00:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1D10D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:00:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5778fe9d183so1415840a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694541599; x=1695146399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9739jBye7YDVaKx0qavfwQvrBru9U0qjivWAjZZ6DgQ=;
        b=VNYEHWLAXsC0ABgFPW+1JuVJ0aAI5vqujBG46e9CQxts72eD1mVhiSg6xUSn6MeljT
         JH8HJFnhCXIMFo80qAVzOe5tLpnBL4g5Dk0aDsunOA8LUNZQ5iR79vUxXpzH3Pf0dUUH
         QCzIJTyj5Mg3twHmlwwKlT+95A1mjes4ZIJEXVePu0nypYTZRA3Z7IsaG/kYZLfdbbgo
         UYhusRYi+Q+Dqs/DEbNRM9+f1wjqjhtw9ousTEPznj0e123Sp2pvuvGq5vkIq75gXcw6
         iP/FAXK8ewmELjnTeQxHj0bEaYTLXm1pOnG4lxJExO6xTLsn/TxSISBc8vWacViICBh1
         NMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541599; x=1695146399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9739jBye7YDVaKx0qavfwQvrBru9U0qjivWAjZZ6DgQ=;
        b=ZHjnoeudgmS1asLVCzedDhnIf8A9q3LkZhi9uS5e2oz9wg4OkdqRLX4zS/4oE+wKlW
         rOtNjCc8germ47uyhrP/mbZohRizm+iv32wN5U2DlmklimlA/rd0O0tceDfMwr9GzIh4
         NLsBJPOJPAW6r1MtdW+0dAfYnzrddJGISyY+EMOaKK7UPJlKEkTmC8q6dh4xf5FzD+dK
         Hzln4sJewef0nLfVi4OQcRa7Dq1+UoRbFtHp6btszafRuhmXjmoFuY6njd6uLxyC9QYT
         K77DnLTwF14gK3R5XW+eLXZTLVuqEu6HLEHhwiZdv7gLP/HNf+4JCEb79GyBrYcxl8bd
         zQxg==
X-Gm-Message-State: AOJu0YwjL955kgmkqzrz55vnRyTHpBORq8sTyLq7tOgm7aJOtAlW3jjO
        yLmyF1laNylXTgchG4127M0=
X-Google-Smtp-Source: AGHT+IEE9RzYbIQ5h5xJ2HvXICYCeyCG5rqW4/yPhJVocsGS0KXEegCI/WLkD5ZJhOxv6Uit/oexRA==
X-Received: by 2002:a17:90b:4a82:b0:268:3f2d:66e4 with SMTP id lp2-20020a17090b4a8200b002683f2d66e4mr10939316pjb.37.1694541599294;
        Tue, 12 Sep 2023 10:59:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gf4-20020a17090ac7c400b00263e1db8460sm6178702pjb.9.2023.09.12.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:59:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Sep 2023 10:59:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>
Subject: Re: Linux 6.6-rc1
Message-ID: <3c85e5f7-c9a4-4c77-b4e9-3b476ac6c1fb@roeck-us.net>
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 04:53:55PM -0700, Linus Torvalds wrote:
> Here we are, two weeks later, and the merge window is closed.
> 
[ ... ]
> 
> Please do give it all a whirl,
> 

Build results:
	total: 157 pass: 151 fail: 6
Failed builds:
	alpha:allmodconfig
	csky:allmodconfig
	m68k:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
Qemu test results:
	total: 530 pass: 522 fail: 8
Failed qemu tests:
	<all s390>

Build failures are all:

drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]

Caused by commit ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver").
Will be fixed with
https://lore.kernel.org/r/20230822114914.340359-1-ckeepax@opensource.cirrus.com

Runtime crashes (s390):

Unable to handle kernel pointer dereference in virtual kernel address space
...
Call Trace:
  kunit_next_attr_filter+0xc8/0x1c8

Caused by commit 76066f93f1df ("kunit: add tests for filtering attributes").
Will be fixed with
https://lore.kernel.org/r/20230830002116.3768675-1-davidgow@google.com

New runtime warnings:

arm:mcimx6ul-evk:

WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2396 _regulator_put.part.0+0x1b4/0x1d8

Caused by commit 422f10adc3eb ("ASoC: wm8960: Add support for the power supplies").
Will be fixed with
https://lore.kernel.org/lkml/20230909120237.2646275-1-linux@roeck-us.net/

loongarch:

INFO: trying to register non-static key.

Caused by commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
more"). No fix available as far as I know.

Guenter
