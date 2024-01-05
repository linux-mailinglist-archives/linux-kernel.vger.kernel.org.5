Return-Path: <linux-kernel+bounces-17914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0B82550A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24601F23960
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083742D7BE;
	Fri,  5 Jan 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bDidyq/X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0452D7B2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1915034144so184248266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704464211; x=1705069011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7U1U09z3TOeegDNy86IPlrzYZyW+9O5Q8wyI3jKg8Dc=;
        b=bDidyq/XI6By47y8ebbW5gAIQ/aNjOeKVb1DAPfdaTAS5oabqjgnELwTOZbobDQt9C
         zimJ5qIO3CjXwTsBvh0qU167AnSkuXVJOnGqliNuOPAnE2F1LcT63gZdpPw2g5Nx7k5r
         8I4+ibMw7vC5M5aeEcWSz13HTZDysY4CMHZXwiYTL+70uvEDJiJxC591Oww1z8SjnwhB
         0k9tL2qwEnT4ifjF75A5f6uvqcpM7ONZsaEZ/YIIk6if7vF339lYLC2YdxKWr0kAhME+
         j0+ccnrV0k7EQT27ctKrn14l2lbI1CsYYkPuq6oSZcbzcY6fe9GUjW1dKT7rAg3Xab01
         W+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464211; x=1705069011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U1U09z3TOeegDNy86IPlrzYZyW+9O5Q8wyI3jKg8Dc=;
        b=q1eAIiHYIwcZJmH8iNUSClKhPFJV+JG8ZC5X5hDehrVd8Z+NiPTYH1Ebmiv/sZIPoe
         7qrcc9++gMcZGdMQK4HG8Y/DJliF6fSOOx9ZT3P3uJL97mQFYgaxzgXga1NFDj44P1++
         ba2ExUZVER5C2Kp1MYnMZFdlqlM5yjLYquECkc/CSmf4oqL0IBKjEH0sPJTHRtDstRFp
         iVi45dyD3C5RpeI1UJ2hKPwHdK6rW6Bjl860cwkzJXH5tIWbtqMQT+0bQEwy7KORJXhN
         /V4ejhWY9s9wkxCYpMtFbFxQlDxBIfxmEFNtQm8CTqLd2I7e/vT7yW2DQWVZ/qUVoOfF
         kfwQ==
X-Gm-Message-State: AOJu0YyFAo5PHYlGf+cIZZfDYkGDCcZkbTfuMNRrVwXRtl6fN0pzXuNb
	gNxUmEzeYlOW84q5ZICq6RixvzfExKs18A==
X-Google-Smtp-Source: AGHT+IEy9OpGObmTsp6Vssi6XSCxWEqxRnfpRv09W/5AOlxtpyya6zeM7WBWQZgtOU51iVS0fsbhYQ==
X-Received: by 2002:a17:906:4ad3:b0:a29:4267:ac9 with SMTP id u19-20020a1709064ad300b00a2942670ac9mr422848ejt.52.1704464210875;
        Fri, 05 Jan 2024 06:16:50 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id am19-20020a170906569300b00a26ac57b951sm926158ejc.23.2024.01.05.06.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:16:50 -0800 (PST)
Date: Fri, 5 Jan 2024 15:16:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: Lukas Hruska <lhruska@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v1 5/5] documentation: Update on livepatch elf format
Message-ID: <ZZgPUSXzQBQewDFL@alley>
References: <20231106162513.17556-1-lhruska@suse.cz>
 <20231106162513.17556-6-lhruska@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106162513.17556-6-lhruska@suse.cz>

On Mon 2023-11-06 17:25:13, Lukas Hruska wrote:
> Add a section to Documentation/livepatch/module-elf-format.rst
> describing how klp-convert works for fixing relocations.
> 
> Signed-off-by: Lukas Hruska <lhruska@suse.cz>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

