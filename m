Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE57D4803
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjJXHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjJXHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:09:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BAF10C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:09:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso35395035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698131375; x=1698736175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bg3/yG5alTR9cURzI2G+r1/RbWGLer43z8qyypczxLw=;
        b=Es5LaCKFhseaBU5oll84kZYT2OmAJo7qfuMEdVFj5z5cMPOZwB04F9A0rA47M+NlQm
         uQqljutvsShk+pazg0qG45M6bfa+ncEdwNImh/yNTWeYuyYpwNqBqVFegUCT3uwn4CqR
         +agV5NPGRZXlVQy30QdF36xpPCRUsxmJp1SaEsQCwfBj9CS44dzve6xZ5wU0be1Z2QXl
         sfc6KcmwyxbLfT3miiDpVOtNLmhut6H0/uSwpx6tSrPuwm3TzeuAvPkipx9pgRxn1epS
         CHk3jAqyy4+1/Lp+0v2jPaGZxFsu3f8aNnukKz2enTGlL9biGtTkyZh5Rp+f8SQrdK3z
         nYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131375; x=1698736175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg3/yG5alTR9cURzI2G+r1/RbWGLer43z8qyypczxLw=;
        b=kvODMKyhwHjpIiKjTDo23hNRWdxb3VZsAKXZqJSebaCd5CWe9K5aHTQ/fisAiZUkRX
         jaqjMT0ayHRp5fZBtUm9yo21tP1viLe1ZD/J62bYtb3Kf9uUrqwsGbMzyUVDkO0hoqkC
         64ONXYap2ejXYWmIj3wOSTkTEuW51lYphpem3ysBJlQxDFBA6TNVwl59Izyoxgy64BWJ
         qoVRiHUyvqzefUFBbiiwCEGT6Q5T6Q8TA9kPdYhgA7ux1LlJrDqVo9I//2WgsZn82cnb
         byxEOSDCqhgiK8gmhcmXC8l9u5a0wKavjV6C9jFuj10seJ6VSUcv1mf2t94BuMcQQ3lA
         9oSw==
X-Gm-Message-State: AOJu0YwStCVpjcqcC/7VZVlJZnvgHWlzvI9I7YIvmtycDCRkQOLPkNAU
        nrNGx5Y8C77NesshEWF2/IsDxA==
X-Google-Smtp-Source: AGHT+IG82Wy7z7LaS15pZRBGLYgELtLF6fUMo8x83zDPQE5+VC1wueXV6hw8d9oATcWQwSIY0XVuQQ==
X-Received: by 2002:a05:600c:4fc9:b0:402:8c7e:3fc4 with SMTP id o9-20020a05600c4fc900b004028c7e3fc4mr9410480wmq.30.1698131375586;
        Tue, 24 Oct 2023 00:09:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b00407752f5ab6sm11368047wmo.6.2023.10.24.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:09:34 -0700 (PDT)
Date:   Tue, 24 Oct 2023 10:09:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in
 create_of_modalias()
Message-ID: <6c38f870-8f89-4955-abd5-50439853e440@kadam.mountain>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
 <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
 <ae1f9a0a-2058-4126-b716-44dc54449c4d@kadam.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gSLSPFJSYIsxf/4V"
Content-Disposition: inline
In-Reply-To: <ae1f9a0a-2058-4126-b716-44dc54449c4d@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gSLSPFJSYIsxf/4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2023 at 09:08:26AM +0300, Dan Carpenter wrote:
> So I had a Smatch check for this kind of stuff but it was pretty junk.
> It also only looked for "modalias + len" and here the code is doing
> "&modalias[len]".
> 
> I can fix it up a bit today and look again at the warnings.  Here is the
> the check and the warnings as-is.

Alright.  Here is the new version.  :)

regards,
dan carpenter

--gSLSPFJSYIsxf/4V
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_snprintf_no_minus.c"

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"
#include "smatch_extra.h"

static int my_id;

STATE(plus_equal);
STATE(minus_equal);

static bool is_plus_address(struct expression *expr)
{
	sval_t sval;

	if (expr->type != EXPR_PREOP ||
	    expr->op != '&')
		return false;

	expr = expr->unop;
	if (expr->type != EXPR_PREOP ||
	    expr->op != '*')
		return false;

	expr = expr->unop;
	if (expr->type != EXPR_BINOP ||
	    expr->op != '+')
		return false;

	if (get_implied_value(expr->right, &sval) && sval.value == 0)
		return false;

	return true;
}

static bool is_plus(struct expression *expr)
{
	struct expression *tmp;
	sval_t sval;

	tmp = get_assigned_expr(expr);
	if (tmp)
		expr = tmp;
	expr = strip_expr(expr);
	if (expr->type == EXPR_BINOP && expr->op == '+') {
		if (get_implied_value(expr->right, &sval) && sval.value == 0)
			return false;
		return true;
	}

	if (is_plus_address(expr))
		return true;

	if (get_state_expr(my_id, expr) == &plus_equal)
		return true;

	return false;
}

static bool is_minus(struct expression *expr)
{
	struct expression *tmp;

	tmp = get_assigned_expr(expr);
	if (tmp)
		expr = tmp;
	expr = strip_expr(expr);
	if (expr->type == EXPR_BINOP && expr->op == '-')
		return true;
	/*
	 * If, after calling strip_expr, the expression is still () that means
	 * it is an EXPR_STATEMENT and some kind of complicated macro.
	 */
	if (expr->type == EXPR_PREOP && expr->op == '(')
		return true;
	if (get_state_expr(my_id, expr) == &minus_equal)
		return true;
	return false;
}

static void match_snprintf(const char *fn, struct expression *expr, void *unused)
{
	struct expression *dest, *limit;
	char *name;

	dest = get_argument_from_call_expr(expr->args, 0);
	limit = get_argument_from_call_expr(expr->args, 1);
	dest = strip_expr(dest);
	limit = strip_expr(limit);
	if (!dest || !limit)
		return;

	if (!is_plus(dest))
		return;

	if (is_minus(limit))
		return;

	name = expr_to_str(limit);
	sm_warning("expected subtract in snprintf limit '%s'", name);
	free_string(name);
}

static void match_assign(struct expression *expr)
{
	if (expr->op == SPECIAL_ADD_ASSIGN)
		set_state_expr(my_id, expr->left, &plus_equal);

	if (expr->op == SPECIAL_SUB_ASSIGN)
		set_state_expr(my_id, expr->left, &minus_equal);
}

void check_snprintf_no_minus(int id)
{
	my_id = id;

	add_function_hook("snprintf", &match_snprintf, NULL);
	add_function_hook("scnprintf", &match_snprintf, NULL);

	add_hook(&match_assign, ASSIGNMENT_HOOK);
}


--gSLSPFJSYIsxf/4V--
