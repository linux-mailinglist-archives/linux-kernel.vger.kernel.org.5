Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702757E82AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjKJT3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbjKJT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE58253
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699599988; x=1700204788; i=deller@gmx.de;
        bh=zOdtjhaIenhyimwheJBqU7h0lGLGDz7g9pte3YxcbEM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=V+U3sZ8hMohk8t6pcvyV0nySOMiw1gx5Ga7L56sN7XX3sSUz8s6gXfoDW5P0ghcG
         obsFcFGsxxQ5teeSbKQNH3CvHwQj7C9RSmcg7cLbEITIePKY0S/OxKCwWWBEo3cQX
         6teevxsU1UpW9UihQ0ysFQLm7euwIEjNrD3oFcNNsVCZ00dVslMxykzC+aSp/zwLK
         YrggrosxCzjEwLHaZzIEzCLJ87C7wlnu6zSBwwrBsALXihL+a2VP6dgaUoh6mgTc9
         b/T9ngjJTSZUkaQCHOa6wbB77cL/ZOxVQrW4BrG3XpkbMvE/cFmW8zalnU3pNj1zG
         6IPJBhbt9vHZiWm+tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1reEa231B0-00fSHV; Fri, 10
 Nov 2023 08:06:28 +0100
Message-ID: <e0890b48-d630-4179-89a2-86bb953ae2bf@gmx.de>
Date:   Fri, 10 Nov 2023 08:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] fbdev/fsl-diu-fb: mark wr_reg_wa() static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-22-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20231108125843.3806765-22-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6kDMcs86IPEWFleDGKDc3P5UnvS7gGsJ+K1nrEfeSO/wFk408XO
 4SntItnA2Leuzi+oF31U3iTL3gQ1x4I8M9u+UlXsgg11LAXhaZDxZ7lYd4XGMyv80VWtw7y
 R3jMNIBsnqD4FLz12FNH4a20KFq6n3Jw8uVoCfJnzwNyCOB1SnKYDYFquxKaE18IULrPBQ2
 dPmdp6+ThLg1bgRmmm+wg==
UI-OutboundReport: notjunk:1;M01:P0:7osXESTX6Zs=;N4zrjFgggK3O2U32DiOhhUL0dRj
 HrqcScV7A+48yLXCjz6XvSZDk73Yk1pi47sAVvF1fIoiM7Ic6ld0SJ5qLFHz50EHJIU4ibtKx
 xgUsdBeP13AwimLI02hR+ftdnpuJXSY/obPtIg/0Aq05LAlrz8w++QwGrh35jDWIu5U0VzmX/
 UUtde/Gc+l0OYAdPWPVhd/a2dFC5/ltesfwiqLXURQAh+jcgtK1lxmA1HIoKxdPh3xuF6D89o
 PflDHdQh5LCGP6eQxltSEFOiTQPadiRk+kVFQaFMYn3xUeuo8VWL4TH+d1ZpGcpXXeAsmi/Jd
 WShoUsS1566tyg9j9OwU5UNaCMz11d9yREv/hKtYdLdYRrf8A5vAE1haTMV1jwxgI48ZkcMzr
 su3+vK/7W5WlcwPTrhm+0ijriEHwcxUqFO2jIXyQGmBvqMwEHUqsZXyCWo3FRacNNQiVmmBsx
 uIlvPbEf1bbjdmnRccfPcD2RZtMy6RgL3ln35cC5WEjLHFW0wTUsgkoZlH8BhjB4fNvizY7WI
 zm4xllUX2X24SmfGlg1Za7loXStdAziyiLpjmG1zNThO1Rl6ViDpdONkvhxsqIrdlzAGLas4H
 Bvw5+37V7u/f7O2mX5kBbBoipihH0rSgaYA8NsIWIGaQM11H/OC0G1y63T7VBkA8JgJVED45a
 svKr9e/akfI7AXHkU5xwSazqSd+pbFI4/vlFEYBkSWyaxuk0NuLeJ90O/sp7b4g7rG2RSXJe7
 ISeugvFlUMnLpf4QncfA2Mw6JKcUAioL1IQ5xSiXHOByFeQEfdFAR71iu2uhWGj2xOvLEBbiN
 Erz0zojy1gckHvKEHH1+2gw7QkayW0xSz5WMYhH78XUEJ4HILnw8ktvoyOP0VwtVeQ/447k69
 Tba3LxRMPfwe2W3zYzhtW9IQFj5vDvdM0erzlcdTjcgWwgkFYZTtKHLHwzuo4OyNDh9JC+VIj
 tMloxKW8mUzcrKsec50fcvKBHs8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 13:58, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> wr_reg_wa() is not an appropriate name for a global function, and doesn'=
t need
> to be global anyway, so mark it static and avoid the warning:
>
> drivers/video/fbdev/fsl-diu-fb.c:493:6: error: no previous prototype for=
 'wr_reg_wa' [-Werror=3Dmissing-prototypes]
>
> Fixes: 0d9dab39fbbe ("powerpc/5121: fsl-diu-fb: fix issue with re-enabli=
ng DIU area descriptor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

applied this patch to the fbdev git tree.

Thanks!
Helge


> ---
>   drivers/video/fbdev/fsl-diu-fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-=
diu-fb.c
> index 7fbd9f069ac2..0bced82fa494 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -490,7 +490,7 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_por=
t(const char *s)
>    * Workaround for failed writing desc register of planes.
>    * Needed with MPC5121 DIU rev 2.0 silicon.
>    */
> -void wr_reg_wa(u32 *reg, u32 val)
> +static void wr_reg_wa(u32 *reg, u32 val)
>   {
>   	do {
>   		out_be32(reg, val);

