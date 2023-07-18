Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422375734B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGRFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:41:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C1E43;
        Mon, 17 Jul 2023 22:41:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b318c5a7so41729945ad.3;
        Mon, 17 Jul 2023 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689658900; x=1692250900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vv9eDJnvbb5dBRT5pFLE7rtqLSejK4jdBqn5u4eDYWA=;
        b=aHQBHGPERtvhfe/9jYN/UWFWuAXE8T7dgkMg1zYNPb98ADNR7Y5uYA8hYaWn/GFakW
         2YvZX107SY9IcQql16Ugu27gyLlfcS8clCFP9oO7VtBf/AwVDcVg7nZKI21te04hd9+t
         hZO7LM7uhpimLGwG8XJabnJbnLswOKQDsXrlD1fbLjCmM5gGXoZ0B9lK8AOVRtob1vp7
         gZXiPgsZMbyDeT8vC8T286I+sAixgafYG7mbfe9aAUxivPOVDJCJ3UxYEFWxPtffjhcU
         XT1w5iCzPHKjXOJhkEjMGUaBsD5nWOhWN8QuhWPY2EznpjztX3q6jRnjVpYcUUU8OMA6
         3ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689658900; x=1692250900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv9eDJnvbb5dBRT5pFLE7rtqLSejK4jdBqn5u4eDYWA=;
        b=aNuMiiufh2XB7ZMphY4BrsXM3BDfyA+ffpgVNjP/MN0Awzf9OmJeNLXPu9uqVwTWI9
         8GS2/OMC4Wl4K55l1TBHoG3CGLkODYC7+NZ0XW+NcxduWenYzYvjKzh0eNl7mbc7yQsZ
         kR/IjukseoylfxOCAjNtUDzsoHIz9jIfRUuAdxMdZPaO1g3zKrawDa8zeC6AlQrI3Ixd
         WuivGqyFZoW1Rn66LjcrIkEAbN/Y2McPRZGiXRfp22cdpzMkqE06szhfhPGtwezzIOfb
         VwDNpH86K1rmbvUxERr7XCxlLcrDNui6pKhDDE2Zk73GtY/CxB39Vtt9ioD99HVxoEVj
         Wjbg==
X-Gm-Message-State: ABy/qLYVuBSspB/k9AvWFI7MHdj86Wi1NH+b+N328Tz/XG42Rwzpu27r
        Qw+NME2jK8pZmDHOXRWO/Mw=
X-Google-Smtp-Source: APBJJlG9Irh31wT5W3y1mcUdfJWlCvXuuIZBB00410miZTaBlh/vgNzc8N+7XTbArtOinCsg52E9jQ==
X-Received: by 2002:a17:903:22c4:b0:1b8:88c5:2d2f with SMTP id y4-20020a17090322c400b001b888c52d2fmr14730492plg.64.1689658899894;
        Mon, 17 Jul 2023 22:41:39 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001b8b26fa6c1sm851396plo.115.2023.07.17.22.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 22:41:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C97AB82EDCC2; Tue, 18 Jul 2023 12:41:35 +0700 (WIB)
Date:   Tue, 18 Jul 2023 12:41:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     shijie001@208suo.com, masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: gconf: Fix errors in gconf.c
Message-ID: <ZLYmD6SpOF7f05+f@debian.me>
References: <tencent_A89FDF5260295CB618D587A53D21C96FF90A@qq.com>
 <90e8f79ec40ab4ce1c7e7961cb77a012@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="20mp7W3COSWF8X5Z"
Content-Disposition: inline
In-Reply-To: <90e8f79ec40ab4ce1c7e7961cb77a012@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--20mp7W3COSWF8X5Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 01:18:06PM +0800, shijie001@208suo.com wrote:
> diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
> index 17adabfd6e6b..2d41058bec8c 100644
> --- a/scripts/kconfig/gconf.c
> +++ b/scripts/kconfig/gconf.c
> @@ -66,8 +66,8 @@ enum {
>  static void display_list(void);
>  static void display_tree(struct menu *menu);
>  static void display_tree_part(void);
> -static void update_tree(struct menu *src, GtkTreeIter * dst);
> -static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row=
);
> +static void update_tree(struct menu *src, GtkTreeIter *dst);
> +static void set_node(GtkTreeIter *node, struct menu *menu, gchar **row);
>  static gchar **fill_row(struct menu *menu);
>  static void conf_changed(void);
>=20
> @@ -254,8 +254,8 @@ static void init_left_tree(void)
>  }
>=20
>  static void renderer_edited(GtkCellRendererText * cell,
> -                const gchar * path_string,
> -                const gchar * new_text, gpointer user_data);
> +                const gchar *path_string,
> +                const gchar *new_text, gpointer user_data);
>=20
>  static void init_right_tree(void)
>  {
> @@ -407,8 +407,8 @@ static void text_insert_msg(const char *title, const
> char *message)
>=20
>  /* Main Windows Callbacks */
>=20
> -void on_save_activate(GtkMenuItem * menuitem, gpointer user_data);
> -gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
> +void on_save_activate(GtkMenuItem *menuitem, gpointer user_data);
> +gboolean on_window1_delete_event(GtkWidget *widget, GdkEvent *event,
>                   gpointer user_data)
>  {
>      GtkWidget *dialog, *label;
> @@ -453,15 +453,15 @@ gboolean on_window1_delete_event(GtkWidget * widget,
> GdkEvent * event,
>  }
>=20
> -void on_window1_destroy(GtkObject * object, gpointer user_data)
> +void on_window1_destroy(GtkObject *object, gpointer user_data)
>  {
>      gtk_main_quit();
>  }
>=20
>  void
> -on_window1_size_request(GtkWidget * widget,
> -            GtkRequisition * requisition, gpointer user_data)
> +on_window1_size_request(GtkWidget *widget,
> +            GtkRequisition *requisition, gpointer user_data)
>  {
>      static gint old_h;
>      gint w, h;
> @@ -483,7 +483,7 @@ on_window1_size_request(GtkWidget * widget,
>=20
>  static void
> -load_filename(GtkFileSelection * file_selector, gpointer user_data)
> +load_filename(GtkFileSelection *file_selector, gpointer user_data)
>  {
>      const gchar *fn;
>=20
> @@ -496,7 +496,7 @@ load_filename(GtkFileSelection * file_selector, gpoin=
ter
> user_data)
>          display_tree(&rootmenu);
>  }
>=20
> -void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_load1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkWidget *fs;
>=20
> @@ -516,7 +516,7 @@ void on_load1_activate(GtkMenuItem * menuitem, gpoint=
er
> user_data)
>  }
>=20
> -void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_save_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      if (conf_write(NULL))
>          text_insert_msg("Error", "Unable to save configuration !");
> @@ -525,7 +525,7 @@ void on_save_activate(GtkMenuItem * menuitem, gpointer
> user_data)
>=20
>  static void
> -store_filename(GtkFileSelection * file_selector, gpointer user_data)
> +store_filename(GtkFileSelection *file_selector, gpointer user_data)
>  {
>      const gchar *fn;
>=20
> @@ -538,7 +538,7 @@ store_filename(GtkFileSelection * file_selector,
> gpointer user_data)
>      gtk_widget_destroy(GTK_WIDGET(user_data));
>  }
>=20
> -void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_save_as1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkWidget *fs;
>=20
> @@ -558,14 +558,14 @@ void on_save_as1_activate(GtkMenuItem * menuitem,
> gpointer user_data)
>  }
>=20
> -void on_quit1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_quit1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      if (!on_window1_delete_event(NULL, NULL, NULL))
>          gtk_widget_destroy(GTK_WIDGET(main_wnd));
>  }
>=20
> -void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_show_name1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkTreeViewColumn *col;
>=20
> @@ -576,7 +576,7 @@ void on_show_name1_activate(GtkMenuItem * menuitem,
> gpointer user_data)
>  }
>=20
> -void on_show_range1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_show_range1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkTreeViewColumn *col;
>=20
> @@ -594,7 +594,7 @@ void on_show_range1_activate(GtkMenuItem * menuitem,
> gpointer user_data)
>  }
>=20
> -void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_show_data1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkTreeViewColumn *col;
>=20
> @@ -632,7 +632,7 @@ on_set_option_mode3_activate(GtkMenuItem *menuitem,
> gpointer user_data)
>  }
>=20
> -void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_dat=
a)
> +void on_introduction1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkWidget *dialog;
>      const gchar *intro_text =3D
> @@ -663,7 +663,7 @@ void on_introduction1_activate(GtkMenuItem * menuitem,
> gpointer user_data)
>  }
>=20
> -void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_about1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkWidget *dialog;
>      const gchar *about_text =3D
> @@ -681,7 +681,7 @@ void on_about1_activate(GtkMenuItem * menuitem, gpoin=
ter
> user_data)
>  }
>=20
> -void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
> +void on_license1_activate(GtkMenuItem *menuitem, gpointer user_data)
>  {
>      GtkWidget *dialog;
>      const gchar *license_text =3D
> @@ -700,7 +700,7 @@ void on_license1_activate(GtkMenuItem * menuitem,
> gpointer user_data)
>  }
>=20
> -void on_back_clicked(GtkButton * button, gpointer user_data)
> +void on_back_clicked(GtkButton *button, gpointer user_data)
>  {
>      enum prop_type ptype;
>=20
> @@ -715,13 +715,13 @@ void on_back_clicked(GtkButton * button, gpointer
> user_data)
>  }
>=20
> -void on_load_clicked(GtkButton * button, gpointer user_data)
> +void on_load_clicked(GtkButton *button, gpointer user_data)
>  {
>      on_load1_activate(NULL, user_data);
>  }
>=20
> -void on_single_clicked(GtkButton * button, gpointer user_data)
> +void on_single_clicked(GtkButton *button, gpointer user_data)
>  {
>      view_mode =3D SINGLE_VIEW;
>      gtk_widget_hide(tree1_w);
> @@ -730,7 +730,7 @@ void on_single_clicked(GtkButton * button, gpointer
> user_data)
>  }
>=20
> -void on_split_clicked(GtkButton * button, gpointer user_data)
> +void on_split_clicked(GtkButton *button, gpointer user_data)
>  {
>      gint w, h;
>      view_mode =3D SPLIT_VIEW;
> @@ -746,7 +746,7 @@ void on_split_clicked(GtkButton * button, gpointer
> user_data)
>  }
>=20
> -void on_full_clicked(GtkButton * button, gpointer user_data)
> +void on_full_clicked(GtkButton *button, gpointer user_data)
>  {
>      view_mode =3D FULL_VIEW;
>      gtk_widget_hide(tree1_w);
> @@ -757,13 +757,13 @@ void on_full_clicked(GtkButton * button, gpointer
> user_data)
>  }
>=20
> -void on_collapse_clicked(GtkButton * button, gpointer user_data)
> +void on_collapse_clicked(GtkButton *button, gpointer user_data)
>  {
>      gtk_tree_view_collapse_all(GTK_TREE_VIEW(tree2_w));
>  }
>=20
> -void on_expand_clicked(GtkButton * button, gpointer user_data)
> +void on_expand_clicked(GtkButton *button, gpointer user_data)
>  {
>      gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
>  }
> @@ -772,9 +772,9 @@ void on_expand_clicked(GtkButton * button, gpointer
> user_data)
>  /* CTree Callbacks */
>=20
>  /* Change hex/int/string value in the cell */
> -static void renderer_edited(GtkCellRendererText * cell,
> -                const gchar * path_string,
> -                const gchar * new_text, gpointer user_data)
> +static void renderer_edited(GtkCellRendererText *cell,
> +                const gchar *path_string,
> +                const gchar *new_text, gpointer user_data)
>  {
>      GtkTreePath *path =3D gtk_tree_path_new_from_string(path_string);
>      GtkTreeIter iter;
> @@ -855,7 +855,7 @@ static void toggle_sym_value(struct menu *menu)
>          display_tree_part();    //fixme: keep exp/coll
>  }
>=20
> -static gint column2index(GtkTreeViewColumn * column)
> +static gint column2index(GtkTreeViewColumn *column)
>  {
>      gint i;
>=20
> @@ -873,8 +873,8 @@ static gint column2index(GtkTreeViewColumn * column)
>=20
>  /* User click: update choice (full) or goes down (single) */
>  gboolean
> -on_treeview2_button_press_event(GtkWidget * widget,
> -                GdkEventButton * event, gpointer user_data)
> +on_treeview2_button_press_event(GtkWidget *widget,
> +                GdkEventButton *event, gpointer user_data)
>  {
>      GtkTreeView *view =3D GTK_TREE_VIEW(widget);
>      GtkTreePath *path;
> @@ -930,8 +930,8 @@ on_treeview2_button_press_event(GtkWidget * widget,
>=20
>  /* Key pressed: update choice */
>  gboolean
> -on_treeview2_key_press_event(GtkWidget * widget,
> -                 GdkEventKey * event, gpointer user_data)
> +on_treeview2_key_press_event(GtkWidget *widget,
> +                 GdkEventKey *event, gpointer user_data)
>  {
>      GtkTreeView *view =3D GTK_TREE_VIEW(widget);
>      GtkTreePath *path;
> @@ -975,7 +975,7 @@ on_treeview2_key_press_event(GtkWidget * widget,
>=20
>  /* Row selection changed: update help */
>  void
> -on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
> +on_treeview2_cursor_changed(GtkTreeView *treeview, gpointer user_data)
>  {
>      GtkTreeSelection *selection;
>      GtkTreeIter iter;
> @@ -991,8 +991,8 @@ on_treeview2_cursor_changed(GtkTreeView * treeview,
> gpointer user_data)
>=20
>  /* User click: display sub-tree in the right frame. */
>  gboolean
> -on_treeview1_button_press_event(GtkWidget * widget,
> -                GdkEventButton * event, gpointer user_data)
> +on_treeview1_button_press_event(GtkWidget *widget,
> +                GdkEventButton *event, gpointer user_data)
>  {
>      GtkTreeView *view =3D GTK_TREE_VIEW(widget);
>      GtkTreePath *path;
> @@ -1159,7 +1159,7 @@ static gchar **fill_row(struct menu *menu)
>=20
>  /* Set the node content with a row of strings */
> -static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row)
> +static void set_node(GtkTreeIter *node, struct menu *menu, gchar **row)
>  {
>      GdkColor color;
>      gboolean success;
> @@ -1245,7 +1245,7 @@ static GtkTreeIter *gtktree_iter_find_node(GtkTreeI=
ter
> *parent,
>   * Update the tree by adding/removing entries
>   * Does not change other nodes
>   */
> -static void update_tree(struct menu *src, GtkTreeIter * dst)
> +static void update_tree(struct menu *src, GtkTreeIter *dst)
>  {
>      struct menu *child1;
>      GtkTreeIter iter, tmp;

Another checkpatch fix churn.

But hey, you still use Roundcube to send your patches while that MUA corrup=
ts
them, right?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--20mp7W3COSWF8X5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLYmBAAKCRD2uYlJVVFO
o1hiAP9KnfMuANvXdeTqOqw/8venxpTVH9dWUWrZ4Irev5jiowEAuwTkcR2LdPpL
hb2ynh7JXdOkYYm3AAypldfZ8AeLpAE=
=16Lv
-----END PGP SIGNATURE-----

--20mp7W3COSWF8X5Z--
